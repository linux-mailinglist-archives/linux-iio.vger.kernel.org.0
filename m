Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A03496D0C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiAVRU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 12:20:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52312 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiAVRU5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 12:20:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D5FE60E86;
        Sat, 22 Jan 2022 17:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2434C004E1;
        Sat, 22 Jan 2022 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642872056;
        bh=Y6RJY7P+ppmkAO6OetIxI5fEdZKtnL9ZWHGsqK01Cw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TzAyRB5U802m0KJwuLr4sVBxaHpNp1AwHxo97QhKbiUZ5WaElxRmuKZFHTgM5jjPJ
         oAbbFTo9EATT5jNJg4OlybY7JfUJGKmw3nPRD3e2N/Uwo5NwCCe979XT2GarbzooYG
         ldswpzmAAt+QV9mOrUCwNSwlXAVHr/0BYN0tqmeOWFPrkvM5SWWnE8j5VYGbH/stN4
         TnIPbEEut1hAOIaMIn9SAoneBAE8/gkyW7/r679b5tj5yP4My32EmzqBmf72WlgR8B
         sprDzMWvHzdSLwmgG8IpbFhSMB64yZm6ltpo7QsW8KAzyE9phgSPioVbtLPlNFyF0e
         uIwMJCJeBtPnA==
Date:   Sat, 22 Jan 2022 17:27:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 0/3] Add support for LTC2688
Message-ID: <20220122172706.16aec32e@jic23-huawei>
In-Reply-To: <20220121142501.151-1-nuno.sa@analog.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Jan 2022 15:24:58 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The ABI defined for this driver has some subtleties that were previously
> discussed in this RFC [1]. This might not be the final state but,
> hopefully, we are close to it:
>=20
> toggle mode channels:
>=20
>  * out_voltageY_toggle_en
>  * out_voltageY_raw0
>  * out_voltageY_raw1
>  * out_voltageY_symbol
>=20
> dither mode channels:
>=20
>  * out_voltageY_dither_en
>  * out_voltageY_dither_raw
>  * out_voltageY_dither_raw_available
>  * out_voltageY_dither_offset
>  * out_voltageY_dither_frequency
>  * out_voltageY_dither_frequency_available
>  * out_voltageY_dither_phase
>  * out_voltageY_dither_phase_available
>=20
> Default channels won't have any of the above ABIs. A channel is toggle
> capable if the devicetree 'adi,toggle-mode' flag is set. For dither, the
> assumption is more silent. If 'adi,toggle-mode' is not given and a
> channel is associated with a TGPx pin through 'adi,toggle-dither-input',
> then the channel is assumed to be dither capable (there's no point in
> having a dither capable channel without an input clock).
>=20
> changes in v2:
>=20
>  ltc2688:
>   * Use local buffer for regmap read. Do not assume that reg is part of
> larger buffer;
>   * Renamed GPIO to "clr" so that is consistent with the datasheet;
>   * Renamed 'mask' and 'm' to info. 'mask' is a thing from the past;
>   * Removed 'LTC2688_CHAN_TOGGLE()' and defined to static ext_info arrays;
>   * Use 'regmap_set_bits' to set external ref;
>   * Use FIELD_{PREP|GET} for dither amplitude and channel calibbias where
> only 13bits are used;
>   * Use 'regmap_write()' instead of update_bits for channels settings;
>   * Init 'val' at the beginning of the channel configuration loop
> (and drop mask);
>   * Comment 'ltc2688_reg_writable()' to account for the special condition;
>   * Kmemdup default channels so that it can be safely changed per probed
> device;
>   * Replace extended info multiplexer functions by individual functions;
>   * Use raw0 ABI for toggle channels;
>   * Use dedicated offset ABI for dither channels;
>   * Misc changes (spell fixes, blank lines...);
>   * Have a clock property per channel. Note that we this I moved to OF
> since we now have to use 'devm_get_clk_from_child()' which is using
> device_node. Note that I could use 'to_of_node()' but mixing of.h and
> property.h does not feel like a good idea.
>=20
>  ABI:
>   * Added out_voltageY_raw0 ABI for toggle mode;
>   * Added out_voltageY_dither_offset.
>=20
>  Bindings:
>   * Use standard microvolt unit;
>   * Added constrains for adi,output-range-microvolt and removed negative
> values from the dts example;
>   * Moved clocks to the channel object;
>   * Dropped clock-names;
>   * Add a dependency between 'adi,toggle-dither-input' and 'clocks'.
>=20
> Changes in v3:
>=20
>  ltc2688:
>   * Fix mismatch between functions and function pointers detected by kern=
el
> test bot;=20
>   * Always use if (ret) when ret > 0 has no meaning;
>   * Rename ltc2688_bulk_disable -> ltc2688_disable_regulators;
>   * Report dither phase in radians rather than degrees.
>=20
>  ABI:
>   * Specify units for dither_phase and dither_freqency;=20
>   * Say why its useful to have dither_en and toggle_en;
>   * Combine out_voltageY_raw0 and out_voltageY_raw1;
>   * Fix some description issues in out_voltageY_raw{0|1} and
> out_voltageY_symbol.
>=20
>  Bindings:
>   * Remove mentions to ABI (linux specifix);
>   * Slightly rephrased VREF and adi,toggle-dither-input properties and
> suggested.
>   =20
> [1]: https://marc.info/?l=3Dlinux-iio&m=3D163662843603265&w=3D2

Series looks good to me, but will have to wait a little longer for DT and
any other review before I apply it.

Thanks,

Jonathan

>=20
> Nuno S=C3=A1 (3):
>   iio: dac: add support for ltc2688
>   iio: ABI: add ABI file for the LTC2688 DAC
>   dt-bindings: iio: Add ltc2688 documentation
>=20
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   86 ++
>  .../bindings/iio/dac/adi,ltc2688.yaml         |  146 +++
>  MAINTAINERS                                   |    9 +
>  drivers/iio/dac/Kconfig                       |   11 +
>  drivers/iio/dac/Makefile                      |    1 +
>  drivers/iio/dac/ltc2688.c                     | 1070 +++++++++++++++++
>  6 files changed, 1323 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688=
.yaml
>  create mode 100644 drivers/iio/dac/ltc2688.c
>=20

