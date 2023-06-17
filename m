Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEA734352
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jun 2023 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFQT2M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jun 2023 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjFQT2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jun 2023 15:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E51BC9
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 12:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B886112D
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 19:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A2C433C0;
        Sat, 17 Jun 2023 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687030087;
        bh=Z+5UjgKN2FtCnSxaO75yWx9qljc3M5Zm+O/59gACgJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LP+1ygjyj3VH5HvporScvZHeTd04JsR+k+OQd/Zi39d9hz1Y47zHloFMP8OMaVH9v
         qxgvxbeRdbZijgyOvRFJFmFTjcGamFL3jMRMmRDpgXtZQWAgcluSYmU9UmjwW1rvsV
         EOXUrEa+xOCU5hr6pz3qyZAJzcvSiSdtpDpddYVFB+3Y4W60TzYaM8cJ+FYtse4vRl
         XrgXOxnggpSERIgH1JvK5zINilXiVvIfKqIyjlZxUKXE6kHO2GXgkBTD34v659fyqq
         AdCZT2HFlqSqumcVfhunKiLP4z865RbVcTxXwpNhH8vHeqaJ6hkTAkDe+iQdfSHT26
         0lIChxJaxEsKw==
Date:   Sat, 17 Jun 2023 20:28:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Schiller <david.schiller@jku.at>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: Questions about ad5933 driver
Message-ID: <20230617202802.4f7402aa@jic23-huawei>
In-Reply-To: <1068e94915d6512b2acd73a8a930c91538c9de8b.camel@jku.at>
References: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
        <20230606113013.00000530@Huawei.com>
        <1204b19a92343a9e3a6ec5df3cef94f6777e08c4.camel@jku.at>
        <20230607155224.000001d0@Huawei.com>
        <1068e94915d6512b2acd73a8a930c91538c9de8b.camel@jku.at>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Jun 2023 12:37:39 +0200
David Schiller <david.schiller@jku.at> wrote:

> On Wed, 2023-06-07 at 15:52 +0100, Jonathan Cameron wrote:
> > Not 'official' though it is fairly commonly used, but the documented
> > ABI in
> > Documentation/ABI/testing/sysfs-bus-iio*
> > is and these aren't there either.
> >=20
> > I'm not 100% sure this is the right way to solve this ABI gap though
> > so need to have a bit of a think about it.=C2=A0 Using a modifier means=
 we
> > can't
> > use them for anything else, so need to consider if there are other
> > modifiers
> > (or it has meaning for differential channels) when deciding if this is
> > an ABI we want to add. =20
>=20
> The naming of the modifiers is also somewhat confusing. The HW registers
> represent the DFT of the input signal, which together with a gain factor
> is used to calculate the impedance. Dimensionally the quantities are
> admittances. "voltage_real" and "voltage_imag" are therefore not quite
> fitting.

In that case, sounds like we need a new channel type to correctly reflect
that they are admittance rather than pretending they are voltages.

>=20
> Also the sweep setup commands are only run once per buffer (in
> ad5933_ring_preenable). This means a buffer can only be used for one
> sweep and then has to be disabled and enabled again. As the driver does
> not implement any triggers this is right now the only way to start a
> measurement.

This sounds a bit like the impact sensors - where an event triggers a series
of measurements of 'something'.

>=20
> Do you think it would make sense to implement a user-space trigger to
> start a measurement sweep? This would mean that a buffer can be reused.
> Right now the "iio_readdev" test program from libiio does not work due
> to this behavior. I don't know how this is handled on other IIO drivers.

A single trigger normally results in the capture of a single set
of channels measurements.  Here that's sort of the case, but the set of
channels is huge - because each one corresponds to a particular frequency.
There can I think be up to 512 such points.  It would be messy to represent
so many channels (if nothing else some of the ways we store data in IIO -
particularly events, are limited to 256 channels).

My guess is that the calculations around a sweep are sufficiently complex
that, if libiio handled the re setup of a sweep neatly, it would be fine
to go through the disable / reenable of the buffer?
I think bodging in trigger support where a trigger causes 'N' samples would
be tricky.

There is another option though I'm not sure how closely it fits.
A channel can have a scan_type element of repeats which could be set
to a fixed value of 512 (likely all scan_type things it's not runtime
configurable) as this might be considered to be lots of repeated reads
of a single channel.


>=20
> Lastly, should I CC the original author (Michael Hennerich) going
> forward?

Sure - +CC Michael.

>=20
> Thanks!
>=20
>=20

