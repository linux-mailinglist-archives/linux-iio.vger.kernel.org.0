Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401B54F8D8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiFQODg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382416AbiFQODf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 10:03:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0D3B545
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 07:03:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i19so6494928qvu.13
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiwp8bsbcjGAaZzZV6s3gf3i6c0BmFdlOtnUZ+QPRAE=;
        b=TlBfLHbQrtLcxqYB16q2koB2KB/RtRbQ7qkK4JgEIanSxWsYGDBOQRO0Y0AUD8RHRV
         z51ifxgV6eLYIaXG5O5mAuo7dQ/BITpNK3nGgeHr2z7waQTVtmTu8LXCVm0mSPUuClaU
         LnH9oVcUBgaEHTN5FPFORTA02cVVIi/NPqLjvrQyLuTRxGwEFYIEtE0V3fG995eo2OQl
         hayxhqhISOkZHqmHeByUZd8QJLua2f9Awx6guncO4sG16/J9oJAc4a7pNUx8F63rOSRd
         Ovn0wzSL0lmFbj/y10l4NfxZpIAakSSwwb3UAv/KRQY2WtqhTr5jIw4FxMYzM5poWWPl
         HXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiwp8bsbcjGAaZzZV6s3gf3i6c0BmFdlOtnUZ+QPRAE=;
        b=lH0l3XDw+/ilA48tcUHm9JCE5jSPYwPEbRI9q54BncN9V4P18VoqYoKYvMDDlUqiwS
         +NuYZkqwv4JiYinEMasq8Dk4eMyRFvR4KSnd8JXppqlZ/Xp28/lOHIqU9NsZpLYxBaDM
         9R+LoEuoLMcAgin6nOYDeqeK5DUwHvg3ZD3eXo+DyC6Chb48S6cGUlPdSNGd5CNHNG66
         Zk2tlOdCsZKz0mlgFpRi4PegdvPxvSU9e3h4JgTx+BPqSmoENEZV2lc242COoZ4eQ1c9
         wsQnDqXd9j/VaMxRe1SV+2QRxPeWTHu7FDbXNp3LQhYKouwIE70EBjz8QI/NpiBc5FK/
         3g0Q==
X-Gm-Message-State: AJIora8ZsfHlI7AV970dCcspZwrBXz5GuFr/EkUoCGxleLGoBlzqDY8f
        Hzr3ur1oRJmVvUbgrMiG0YbaVw==
X-Google-Smtp-Source: AGRyM1vbbUiWoN5O60iVrqu2Sgx4rsnVuNA+lYFkHp86XhIhEYu/mSw4Nk6C0XEheNKNeKdozF3LRQ==
X-Received: by 2002:a05:6214:5f8d:b0:464:6b1b:1bf2 with SMTP id ls13-20020a0562145f8d00b004646b1b1bf2mr8438028qvb.0.1655474613335;
        Fri, 17 Jun 2022 07:03:33 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006a758ce2ae1sm4416819qkb.104.2022.06.17.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:03:32 -0700 (PDT)
Date:   Fri, 17 Jun 2022 10:03:30 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Message-ID: <YqyJslf2UsM32xRP@fedora>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PdcVgtCMHVmxHtf4"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PdcVgtCMHVmxHtf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2022 at 06:37:14AM +0000, N, Pandith wrote:
> Hi,
>=20
> We have a Intel Timed IO peripheral with following functionalities :
>=20
> 1. Event capture capability - Captures event count and timestamp.
> 2. Pulse generation - periodic or single event generation.
> 3. Return cross-timestamp on request.
>=20
> Timed IO device is being used in various Industrial use cases such as : t=
ime capture, synchronization, fan speed calculation etc.
>=20
> IIO or counter subsystem seems to be suitable for timed-io driver.
>=20
> Is it favourable to implement as part of IIO or counter subsystem ? Wante=
d to know your feedback.
>=20
> We may need to use custom ABI for sysfs based user interaction OR
> Can we enhance ioctl interface to accommodate our use case (counter-chard=
ev.c) ?
> Since timed-io works in nano second precision, ioctl is more suitable.
>=20
> Regards,
> Pandith and Sowjanya
>=20
> ps : resent the mail with plain text as delivery to linux-iio@vger.kernel=
=2Eorg failed.

Hello Pandith and Sowjanya,

What you are describing sounds similar to what counter-chardev.c tries
to solve (i.e. Counter events with timestamps). Would you elaborate more
on how this device works and what you are trying to accomplish with it?

For example, when you refer to an "event count and timestamp", does
count here mean the internal device hardware timestamp or is this the
Linux system timestamp? Does "pulse generation" refer to capturing the
count on some physical line signal, or is this a device-internal timer
countdown trigger event? Is "cross-timestamp" referring to a difference
calculation between two count events?

Thanks,

William Breathitt Gray

--PdcVgtCMHVmxHtf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqyJsgAKCRC1SFbKvhIj
KzCsAQCfRLagWTH90q2mxFYupe0e3leAexardtoyIQa6T//v8wEAw1bh2bKx+bB0
Na/k6m9BU4BgIos+g+prjk9fuY+ycgY=
=Hsb8
-----END PGP SIGNATURE-----

--PdcVgtCMHVmxHtf4--
