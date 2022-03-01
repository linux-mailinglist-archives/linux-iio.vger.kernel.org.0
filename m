Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5364C982F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 23:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiCAWOA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 17:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiCAWN7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 17:13:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872B3F33B;
        Tue,  1 Mar 2022 14:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE3CB81E52;
        Tue,  1 Mar 2022 22:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34917C340EE;
        Tue,  1 Mar 2022 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646172786;
        bh=RQzpIjRH1UzPMi0GzJDEchanURFcHgCpVXny/vDQnJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jN3Dgl1C1b9BIcEVfPPT+vQsFXRq9tuoV1JPtIo6bnP3C0s0XAK3cWxMsEBwJFDer
         lun4X3zwPtHZPq+z5dT4nCEpSPMAR1EwIIvepGDCDFZAp/5Q/8svpQX32QFunTmq9l
         yRgWz0fJnT/M5Bgck9QCyCrJ6ogAalkJEgzeoM45e9X0pazibMh04aZ9YS2xfo5B6F
         RxKyX5Mqx5oxsuGUKW2eSnhdZKz+xbsJLZo1Qh3/M9iwjG//E8G7NrhcrgLz54Rp29
         DLigWGJKFRvVhHzidBssqbYeIkuOCvagCfT9rgFdKRCeSQvKDwwcfUH0YOIFOIuEaB
         K5Uh4RMU8d4TQ==
Date:   Tue, 1 Mar 2022 22:20:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v4 0/3] Add support for LTC2688
Message-ID: <20220301222014.6ec90d4e@jic23-huawei>
In-Reply-To: <20220227124953.02ab01fc@jic23-huawei>
References: <20220225130129.69-1-nuno.sa@analog.com>
        <20220227124953.02ab01fc@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Feb 2022 12:49:53 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 25 Feb 2022 14:01:26 +0100
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> Hi Nuno,
>=20
> Given we are close to the end of this cycle and Andy has been heavily inv=
olved
> in review of this one so I want to give more time for Andy to potentially=
 take
> another look..
>=20
> Hence, I'm going to do something unusual and push out an extra-testing br=
anch with this
> on so we can get through the autobuilder tests in parallel with that extr=
a time.
>=20
> So, applied to the new extra-testing branch of iio.git with the intent to=
 apply
> it to togreg later in a day or two subject to any last minute feedback.

Given we may be very near to the cut off for the merge window (I aim to do =
a pull
request after linux-next is out tomorrow), I've applied this to the togreg
branch of iio.git and pushed it out to be picked up for linux-next.

Thanks,

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > The ABI defined for this driver has some subtleties that were previously
> > discussed in this RFC [1]. This might not be the final state but,
> > hopefully, we are close to it:
> >=20
> > toggle mode channels:
> >=20
> >  * out_voltageY_toggle_en
> >  * out_voltageY_raw0
> >  * out_voltageY_raw1
> >  * out_voltageY_symbol
> >=20
> > dither mode channels:
> >=20
> >  * out_voltageY_dither_en
> >  * out_voltageY_dither_raw
> >  * out_voltageY_dither_raw_available
> >  * out_voltageY_dither_offset
> >  * out_voltageY_dither_frequency
> >  * out_voltageY_dither_frequency_available
> >  * out_voltageY_dither_phase
> >  * out_voltageY_dither_phase_available
> >=20
> > Default channels won't have any of the above ABIs. A channel is toggle
> > capable if the devicetree 'adi,toggle-mode' flag is set. For dither, the
> > assumption is more silent. If 'adi,toggle-mode' is not given and a
> > channel is associated with a TGPx pin through 'adi,toggle-dither-input',
> > then the channel is assumed to be dither capable (there's no point in
> > having a dither capable channel without an input clock).
> >=20
> > changes in v2:
> >=20
> >  ltc2688:
> >   * Use local buffer for regmap read. Do not assume that reg is part of
> > larger buffer;
> >   * Renamed GPIO to "clr" so that is consistent with the datasheet;
> >   * Renamed 'mask' and 'm' to info. 'mask' is a thing from the past;
> >   * Removed 'LTC2688_CHAN_TOGGLE()' and defined to static ext_info arra=
ys;
> >   * Use 'regmap_set_bits' to set external ref;
> >   * Use FIELD_{PREP|GET} for dither amplitude and channel calibbias whe=
re
> > only 13bits are used;
> >   * Use 'regmap_write()' instead of update_bits for channels settings;
> >   * Init 'val' at the beginning of the channel configuration loop
> > (and drop mask);
> >   * Comment 'ltc2688_reg_writable()' to account for the special conditi=
on;
> >   * Kmemdup default channels so that it can be safely changed per probed
> > device;
> >   * Replace extended info multiplexer functions by individual functions;
> >   * Use raw0 ABI for toggle channels;
> >   * Use dedicated offset ABI for dither channels;
> >   * Misc changes (spell fixes, blank lines...);
> >   * Have a clock property per channel. Note that we this I moved to OF
> > since we now have to use 'devm_get_clk_from_child()' which is using
> > device_node. Note that I could use 'to_of_node()' but mixing of.h and
> > property.h does not feel like a good idea.
> >=20
> >  ABI:
> >   * Added out_voltageY_raw0 ABI for toggle mode;
> >   * Added out_voltageY_dither_offset.
> >=20
> >  Bindings:
> >   * Use standard microvolt unit;
> >   * Added constrains for adi,output-range-microvolt and removed negative
> > values from the dts example;
> >   * Moved clocks to the channel object;
> >   * Dropped clock-names;
> >   * Add a dependency between 'adi,toggle-dither-input' and 'clocks'.
> >=20
> > Changes in v3:
> >=20
> >  ltc2688:
> >   * Fix mismatch between functions and function pointers detected by ke=
rnel
> > test bot;=20
> >   * Always use if (ret) when ret > 0 has no meaning;
> >   * Rename ltc2688_bulk_disable -> ltc2688_disable_regulators;
> >   * Report dither phase in radians rather than degrees.
> >=20
> >  ABI:
> >   * Specify units for dither_phase and dither_freqency;=20
> >   * Say why its useful to have dither_en and toggle_en;
> >   * Combine out_voltageY_raw0 and out_voltageY_raw1;
> >   * Fix some description issues in out_voltageY_raw{0|1} and
> > out_voltageY_symbol.
> >=20
> >  Bindings:
> >   * Remove mentions to ABI (linux specifix);
> >   * Slightly rephrased VREF and adi,toggle-dither-input properties and
> > suggested.
> >   =20
> > changes in v4:
> >=20
> >  ltc2688:
> >   * Use reg_size + val_size instead of plain 3 in regmap;
> >   * Use out_unlock instead of unlock in goto labels;
> >   * Add comma to LTC2688_CHANNEL(), ltc2688_regmap_bus and
> > ltc2688_regmap_bus;
> >   * Use __clear_bit() instead of clear_bit();
> >   * Flip the logic in vref regulator so that error condition is handled
> > first;
> >   * Change to device API. With this, we need to_of_node()
> > for devm_get_clk_from_child().
> >=20
> >  ABI:
> >   * Update kernel version.
> >=20
> >  Bindings:
> >   * Add Rob's Rb tag.
> >=20
> > [1]: https://marc.info/?l=3Dlinux-iio&m=3D163662843603265&w=3D2
> >=20
> > Nuno S=C3=A1 (3):
> >   iio: dac: add support for ltc2688
> >   iio: ABI: add ABI file for the LTC2688 DAC
> >   dt-bindings: iio: Add ltc2688 documentation
> >=20
> >  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   86 ++
> >  .../bindings/iio/dac/adi,ltc2688.yaml         |  146 +++
> >  MAINTAINERS                                   |    9 +
> >  drivers/iio/dac/Kconfig                       |   11 +
> >  drivers/iio/dac/Makefile                      |    1 +
> >  drivers/iio/dac/ltc2688.c                     | 1071 +++++++++++++++++
> >  6 files changed, 1324 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc26=
88.yaml
> >  create mode 100644 drivers/iio/dac/ltc2688.c
> >  =20
>=20

