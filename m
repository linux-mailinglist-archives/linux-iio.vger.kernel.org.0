Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BE660AF6
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jan 2023 01:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAGAjZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 19:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjAGAis (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 19:38:48 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8987E87F19
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 16:37:49 -0800 (PST)
Date:   Sat, 07 Jan 2023 00:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673051865; x=1673311065;
        bh=jqfIedNVAb3yzX7+Dhh5jOCHpINUmjfqwn9HucCV8DY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=u+pBLSek9c6dRNlaIk2UrUNlEl5FtR3hmLyMedGMIYMSco7tUnWS0VjaQg9AH+1BB
         RJw+A+vTI2hEU/8Ucse1xfQvUr2P5U/TuCSPByjwU6c57+J045CzjUYRj9umxe6RdD
         ej8DX8R6gBYJVHX1mMbguasqwqVZ2/e9lad6Gretto61CDqImsyRg/0PdKUbdB66U9
         jAcsHLJ8c6NBvJKnTPZzaUMTSyNPq5YNn7g6zhE7SAdykgdK/RB6TfOBNfap4V8IWN
         5l4QHQC4AZeiEfGPaGUME4QuGtWpGk4otcqbpnYnplzSx8qMPiqZ9EATBAkUVBrncy
         kMJv90udJyjOw==
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
From:   Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com>
In-Reply-To: <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com> <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com> <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
Feedback-ID: 13756336:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

------- Original Message -------
On Friday, January 6th, 2023 at 9:08 AM, Kai-Heng Feng <kai.heng.feng@canon=
ical.com> wrote:


> Hi Wahaj,
>=20
> On Fri, Jan 6, 2023 at 12:26 AM Wahaj wahajaved@protonmail.com wrote:
>=20
> > ------- Original Message -------
> >=20
> > On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron Jonathan.Cam=
eron@Huawei.com wrote:
> >=20
> > > On Wed, 28 Dec 2022 14:05:24 +0000
> > > Wahaj wahajaved@protonmail.com wrote:
> >=20
> > > > Hi Jonathan
> > > >=20
> > > > Hope you're doing well. I have been using a laptop that comes with =
a
> > > > CM32181 Light Sensor and after upgrading to the Linux kernel 6.0+, =
my
> > > > laptop cannot seem to suspend because of the PM subsystem error. I
> > > > have narrowed the problem down to this module and I believe that th=
e
> > > > commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culprit
> > > >=20
> > > > The following lines were provided from the journalctl logs:
> > > >=20
> > > > > cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> > > > > acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPLM3218:00=
:
> > > > > PM: failed to suspend async: error -121
> > > >=20
> > > > I would love the chance to be able to work on this given any guidan=
ce
> > > > on where to start
> > >=20
> > > Hi Wahaj,
> > >=20
> > > Certainly seems likely that you have identified the right commit.
> > > As a starting point, resend this email to linux-iio@vger.kernel.org
> > > and Kai-Heng Feng kai.heng.feng@canonical.com
> > >=20
> > > If you could try reverting the commit to be completely sure it is
> > > the cause that would help avoid any doubt.
> > > Superficially the only thing that I can see causing this problem is
> > > a fail of the i2c bus write.
> > >=20
> > > Does the device work prior to suspend? Try cat /sys/bus/iio/iio:devic=
e0/*
> > > and see if you get any errors (may be device1 etc)
> > >=20
> > > If the device wasn't working at all the register writes in probe() sh=
ould
> > > have failed so we shouldn't be trying to suspend it.
> > > It's possible your machine has some unusual power dependencies or
> > > similar that mean the device is getting powered down before we try to
> > > suspend it.
> > >=20
> > > Anyhow, better to have this discussion on list as there are many othe=
r people
> > > who may have more insight than me or be able to replicate and help de=
bug.
> > >=20
> > > Jonathan
> > >=20
> > > > Best Regards,
> > > > Wahaj Javed
> >=20
> > Hi Jonathan and Kai-Heng Feng,
> >=20
> > I am currently using the 5.15 linux kernel for a while now which works =
perfectly fine.
> >=20
> > From what I gather the suspend functionality does work when using an ol=
der Linux version without the PM i2c bus writes.
>=20
>=20
> Does your system use S3 or S2idle to perform suspend?
>=20
My system uses S3 to perform suspend
> > The device does work fine prior to and post attempted suspend with no e=
rrors showing in cat /sys/bus/iio/iio:device0/*
>=20
>=20
> Does in_illuminance_input value change after system suspend?
Yes, the in_illuminance_input value changes after system suspend with or wi=
thout the suspend and resume functions


>=20
> Kai-Heng
>=20
> > Let me know if there's anything I should start looking into
> >=20
> > Best Regards
> > Wahaj Javed

How did the kernel used to suspend/resume before using the suspend and resu=
me functions in the light sensor?

Was the DEFINE_SIMPLE_DEV_PM_OPS introduced as a part of the Linux 6.0+ PM =
rework?

I would like to take on this bug and try to solve it if that's possible


Best Regards
Wahaj Javed
