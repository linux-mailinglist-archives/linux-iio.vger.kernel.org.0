Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AB3553415
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiFUN6q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350291AbiFUN6g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 09:58:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCEE958F
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 06:58:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x75so10119894qkb.12
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jDGTXV0zuRD1pXyp8csYZbSYrFVTrnr8zuFtaZ98ZSU=;
        b=sIygcg1uYOTuuiTvLNgWDPJ8xxzrJccK1ulB+WrfpDYV9yE8nym5LAdJ8F+0Y7XM9o
         9A8Fd9pxFGQrTEou+LDLx2IIsBVyBnb1S5dvCdstllfsLV2edT69QyMHL0IUvn5ZwSMO
         YnQWXPXIdGMsLvfxWhiObLsyWFjapYzqsJbwrMxl+83dW+PVubbJyKl9R1e1E0oddLDy
         LuZxL6zPJiVSazog/Rp0T1lgshghZxflwpf075vIpdwCzjBRx15CX9U6fxvkM19pUUwJ
         1JLpP57pJO+HAEW+cr47+bm9FF48tIT7iygru6stE9qq7czTcwQiCoEeqSZxfOvjs60g
         Bg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jDGTXV0zuRD1pXyp8csYZbSYrFVTrnr8zuFtaZ98ZSU=;
        b=ZomDXTe0iRNTNSG2/uUW1yWL+tj8kqhgdBtvVg+LBsvcL/sPSts7UQWo7T82BCk4B4
         BR8Z0/OfeQ6MrxgTG93XH0XUPuf6NGHMPEgAmH9B6yBJ9E7UjOx2INovNCwqiN3+23S4
         XNNQA6Y4ECFNJ/cETXnnBursQs8lqnPSibLkaizPCORjdiaxKEBBM48dwondH2gV2Vej
         ishYtCpyJUEJWI4kcCXkq6+800Ng1Z3GUZG7Kw7h3GQw87aJwBxrZUsuPMNQtEySggQJ
         L/YBtE2ra4K5anF+xffrPGU+kPBkR+IZZjfvVw5/cZcUYnfwcn1s7rBgoQlt6fmghgWw
         51PQ==
X-Gm-Message-State: AJIora+KYgjdkdAWGv1BI0inTycds05xskJ3m8lsl4sZV+FP0R+nW1q6
        oFNDH5i1wpIkdVEfZrF6103QEQ==
X-Google-Smtp-Source: AGRyM1tXhxXMQcrhBgAYR3LmVnTDyWKVTn9JVEclcpdON+RaEarGUAgxS83F36cw9qnYvh00peJ1hg==
X-Received: by 2002:a05:620a:c52:b0:6a7:8cf2:6c4e with SMTP id u18-20020a05620a0c5200b006a78cf26c4emr20051784qki.614.1655819914567;
        Tue, 21 Jun 2022 06:58:34 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm15244645qko.112.2022.06.21.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:58:33 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:58:31 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc:     "N, Pandith" <pandith.n@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Message-ID: <YrHOh2jqfwc0gCao@fedora>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <ff67454b89fa444db36dee57fac5eb74@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LgrM7rX1xjf8SM6q"
Content-Disposition: inline
In-Reply-To: <ff67454b89fa444db36dee57fac5eb74@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LgrM7rX1xjf8SM6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2022 at 01:01:47AM +0000, Hall, Christopher S wrote:
> N, Pandith <pandith.n@intel.com> wrote:
> > Hi,
> >=20
> > We have a Intel Timed IO peripheral with following functionalities :
> >=20
> > 1. Event capture capability - Captures event count and timestamp.
>=20
> An event is an edge on the input or output signal. Rising, falling,
> or both edges can be selected for counting / timestamping. The
> timestamp and count are captured synchronously.
>=20
> If, for example, the hardware is configured to capture both types of
> input edges, each input edge causes the count to increment by one and
> the ART value (see below) to be captured atomically.
>=20
> To see how this may be useful, consider the case where two event
> occur before software is able to read the first. A count delta of >1
> indicates that an event timestamp was missed.
>=20
> For another example: If the input signal is periodic, the frequency
> offset between the input clock and the local clock can be computed:
>=20
>  (delta ART / delta count) * (nom. input freq / 1e9 ns) *
> 	(1e9 / ART frequency)
>=20
> It is not necessary to read each event to determine the average
> frequency for multiple events.
>=20
> > 2. Pulse generation - periodic or single event generation.
> > 3. Return cross-timestamp on request.
>=20
> This may imply that the Timed I/O logic is driven by a separate device cl=
ock.
> It is not. It is driven by the platform clock - the Always Running
> Timer (ART). ART is directly related to the CPU timestamp counter (TSC).
> ART and TSC can be converted to one another using the following equation:
>=20
> TSC_Value =3D (ART_Value * CPUID.15H:EBX[31:0] )/ CPUID.15H:EAX[31:0] + K
>=20
> ART ticks at the core crystal frequency. Typically this is 38.4 MHz. The
> frequency can be discovered by reading CPUID.15H:ECX[31:0].
>=20
> More information can be found in the Intel Software Developer's
> Manual (SDM) in the Invariant Timekeeping section
> 17.17.4 and Determining the Processor Base Frequency section 18.7.3
> (https://cdrdv2.intel.com/v1/dl/getContent/671200)
>=20
> K is typically zero. A virtualized guest is an example where K !=3D 0. In
> this case, K is offset by the value of the VMCS TSC offset.
>=20
> An example of how ART can be directly converted to system time is in the
> e1000e driver:
>=20
> drivers/net/ethernet/intel/e1000e/ptp.c:e1000e_phc_getcrosststamp()
>=20
> using the following functions:
>=20
> - arch/x86/kernel/tsc.c:convert_art_to_tsc() [ART->TSC]
> - kernel/time/timekeeping.c:get_device_system_crosststamp() [TSC->System =
Time]
>=20
> These are dependent upon TSC being selected as the clocksource. The
> attempted conversion results in an error otherwise.
>=20
> A PHC driver implementation of Timed I/O was proposed:
> - https://lkml.org/lkml/2020/1/31/25
>=20
> that included a cross-timestamp function. This crosstimestamp - in the se=
nse
> of determining the relationship between two independent clocks - is a
> software fiction because system time is based on ART. The cross-timestamp
> value enabled conversion of an event timestamp from ART -> System Time in
> the application in the usual way when using the PHC API.
>=20
> In my opinion, given a (more) greenfield API implementation. ART timestam=
ps
> should not be exposed at the application level at all. All timestamps
> returned to the application should be in terms of system time.
>=20
> There is a chapter (21.3.5) in the Atom(r) x6000E datasheet for Timed I/O:
>=20
> https://cdrdv2.intel.com/v1/dl/getContent/636112?explicitVersion=3Dtrue&w=
apkw=3DEHL%20datasheet
>=20
> Note that the hardware function is called TGPIO.
>=20
> There is also Timed I/O example code using the PHC driver referenced abov=
e:
>=20
> https://www.intel.com/content/www/us/en/develop/documentation/tcc-tools-2=
021-2-developer-guide/top/time-synchronization-and-communication-tools/time=
-aware-gpio-tgpio-samples.html
>=20
> Thanks,
> Christopher

Hi Christopher,

I'm not familiar with the recent HTE code, so I don't know whether it
can handle arbitrary data values; does the HTE code only track GPIO line
states (whether high or low) with respective timestamps, or can it also
track events count values with a respective timestamps?

Despite the events being triggered by GPIO, it seems from your
description that what you're actually concerned with is getting the
count of "events" and a "timestamp" derived from the ART ticks. If those
two values are what you're trying to handle, then the Counter subsystem
character device should be suitable for your needs:
https://www.kernel.org/doc/html/latest/driver-api/generic-counter.html#coun=
ter-character-device

This could be implemented by creating a Counter driver that treats the
events count as its "Count", and the respective ART-derived timestamp as
a its "Count Extension". When an event is triggered, the driver can push
that event to the respective Count character device via a
counter_push_event() call; userspace can add a "Counter Watch" via the
ioctl COUNTER_ADD_WATCH_IOCTL code to watch changes to these two values
(see tools/counter/counter_example.c).

As a side note, the "timestamp" member of struct counter_event serves
more as an event ID for your particular case here because your actual
timestamp is provided by your ART-derived Counter extension component
(whose value can be in terms of system time if you so wish); it'll come
as the "value" member of another struct counter_event following the
struct counter_event containing your events count.

William Breathitt Gray

--LgrM7rX1xjf8SM6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYrHOhwAKCRC1SFbKvhIj
K2+HAP46h7Ue1gXA4CiNgXIY6NXoRTnf3uVQ1/wMAWEjKNZucAD9Fn1bwpV7Y+U5
kUlsNrMG3IZmWpNkdaD3pKoHZAF/ugA=
=iaCg
-----END PGP SIGNATURE-----

--LgrM7rX1xjf8SM6q--
