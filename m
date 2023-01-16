Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEA66C294
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjAPOql (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 09:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjAPOqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 09:46:18 -0500
X-Greylist: delayed 5253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 06:27:15 PST
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C522DD2
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 06:27:14 -0800 (PST)
Date:   Mon, 16 Jan 2023 14:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673879233; x=1674138433;
        bh=i39QKqpSoZZftJ1L2ApX7KSoPR+JUypEHZ6N8oJZhQ4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kLR9KQyOfu/CncqbcqPyCKv04aW6KQ6ArRg4C5YRL2S9i1gYqNMLaimsLahm7vyMF
         P/r9ka7S3SH1a95HP5rN/6/z5EyFEUA+tSxMUYU/wg/i1vq2u9AbwVYGMDoii9niFg
         gqS8GOZsDbbDy/Q9qEFtasY+G1BNn9KGuRl9QF+Zf2cr3F7l1LbRK/7Pz+HkupeUAp
         F5JkWD/KDwnzyn/S35KuXB1k/eGXTTmtfR1wrhHnDU9FRyfl2Xya3jpU79iw6ke+L1
         VHw+SUfa90qUO/8XLNElXqjLhFaVthLRrQeo6w/bWmMFucnGPxYiN8EqEGlojTwQe+
         1EiHaS5bXrdYg==
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
From:   Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <cKYeY4HN3_NekeCl1PMBnzcn-Y64OEXNKTrGyYf3wQQekbNLzQeM5TlsB1rrGlsRSjVxnGJ84CytQ0w2VhFAoAGIrYMZnvqq0XGsnyy71L8=@protonmail.com>
In-Reply-To: <8egyl6OawVGTgDhMmArrWCKWVTp4CxDO3jFgEMjWvk11qEyFVARwV0xoGpwBvB4CHiIVWhXth_2CKznGgCvXxFbPsrIpSwYCn_QSx4aezrk=@protonmail.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com> <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com> <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com> <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com> <20230108124654.514a5b1b@jic23-huawei> <CAAd53p5nz0ehBmg05njKRG7cnBQQgJFpT-1oqDtajSY8Zz0NMw@mail.gmail.com> <8egyl6OawVGTgDhMmArrWCKWVTp4CxDO3jFgEMjWvk11qEyFVARwV0xoGpwBvB4CHiIVWhXth_2CKznGgCvXxFbPsrIpSwYCn_QSx4aezrk=@protonmail.com>
Feedback-ID: 13756336:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org









Sent with Proton Mail secure email.

------- Original Message -------
On Monday, January 16th, 2023 at 3:59 PM, Wahaj <wahajaved@protonmail.com> =
wrote:


> ------- Original Message -------
> On Thursday, January 12th, 2023 at 5:48 AM, Kai-Heng Feng kai.heng.feng@c=
anonical.com wrote:
>=20
>=20
>=20
> > Hi Wahaj,
> >=20
> > On Sun, Jan 8, 2023 at 8:33 PM Jonathan Cameron jic23@kernel.org wrote:
> >=20
> > > On Sat, 07 Jan 2023 00:37:40 +0000
> > > Wahaj wahajaved@protonmail.com wrote:
> > >=20
> > > > ------- Original Message -------
> > > > On Friday, January 6th, 2023 at 9:08 AM, Kai-Heng Feng kai.heng.fen=
g@canonical.com wrote:
> > > >=20
> > > > > Hi Wahaj,
> > > > >=20
> > > > > On Fri, Jan 6, 2023 at 12:26 AM Wahaj wahajaved@protonmail.com wr=
ote:
> > > > >=20
> > > > > > ------- Original Message -------
> > > > > >=20
> > > > > > On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron Jona=
than.Cameron@Huawei.com wrote:
> > > > > >=20
> > > > > > > On Wed, 28 Dec 2022 14:05:24 +0000
> > > > > > > Wahaj wahajaved@protonmail.com wrote:
> > > > > >=20
> > > > > > > > Hi Jonathan
> > > > > > > >=20
> > > > > > > > Hope you're doing well. I have been using a laptop that com=
es with a
> > > > > > > > CM32181 Light Sensor and after upgrading to the Linux kerne=
l 6.0+, my
> > > > > > > > laptop cannot seem to suspend because of the PM subsystem e=
rror. I
> > > > > > > > have narrowed the problem down to this module and I believe=
 that the
> > > > > > > > commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culpr=
it
> > > > > > > >=20
> > > > > > > > The following lines were provided from the journalctl logs:
> > > > > > > >=20
> > > > > > > > > cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> > > > > > > > > acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPL=
M3218:00:
> > > > > > > > > PM: failed to suspend async: error -121
> > > > > > > >=20
> > > > > > > > I would love the chance to be able to work on this given an=
y guidance
> > > > > > > > on where to start
> > > > > > >=20
> > > > > > > Hi Wahaj,
> > > > > > >=20
> > > > > > > Certainly seems likely that you have identified the right com=
mit.
> > > > > > > As a starting point, resend this email to linux-iio@vger.kern=
el.org
> > > > > > > and Kai-Heng Feng kai.heng.feng@canonical.com
> > > > > > >=20
> > > > > > > If you could try reverting the commit to be completely sure i=
t is
> > > > > > > the cause that would help avoid any doubt.
> > > > > > > Superficially the only thing that I can see causing this prob=
lem is
> > > > > > > a fail of the i2c bus write.
> > > > > > >=20
> > > > > > > Does the device work prior to suspend? Try cat /sys/bus/iio/i=
io:device0/*
> > > > > > > and see if you get any errors (may be device1 etc)
> > > > > > >=20
> > > > > > > If the device wasn't working at all the register writes in pr=
obe() should
> > > > > > > have failed so we shouldn't be trying to suspend it.
> > > > > > > It's possible your machine has some unusual power dependencie=
s or
> > > > > > > similar that mean the device is getting powered down before w=
e try to
> > > > > > > suspend it.
> > > > > > >=20
> > > > > > > Anyhow, better to have this discussion on list as there are m=
any other people
> > > > > > > who may have more insight than me or be able to replicate and=
 help debug.
> > > > > > >=20
> > > > > > > Jonathan
> > > > > > >=20
> > > > > > > > Best Regards,
> > > > > > > > Wahaj Javed
> > > > > >=20
> > > > > > Hi Jonathan and Kai-Heng Feng,
> > > > > >=20
> > > > > > I am currently using the 5.15 linux kernel for a while now whic=
h works perfectly fine.
> > > > > >=20
> > > > > > From what I gather the suspend functionality does work when usi=
ng an older Linux version without the PM i2c bus writes.
> > > > >=20
> > > > > Does your system use S3 or S2idle to perform suspend?
> > > >=20
> > > > My system uses S3 to perform suspend
> > > >=20
> > > > > > The device does work fine prior to and post attempted suspend w=
ith no errors showing in cat /sys/bus/iio/iio:device0/*
> > > > >=20
> > > > > Does in_illuminance_input value change after system suspend?
> > > > > Yes, the in_illuminance_input value changes after system suspend =
with or without the suspend and resume functions
> > > >=20
> > > > > Kai-Heng
> > > > >=20
> > > > > > Let me know if there's anything I should start looking into
> > > > > >=20
> > > > > > Best Regards
> > > > > > Wahaj Javed
> > > >=20
> > > > How did the kernel used to suspend/resume before using the suspend =
and resume functions in the light sensor?
> > > >=20
> > > > Was the DEFINE_SIMPLE_DEV_PM_OPS introduced as a part of the Linux =
6.0+ PM rework?
> > >=20
> > > Until https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
> > > which will have hit mainline in 6.0, the driver had no suspend / resu=
me support.
> > >=20
> > > That patch introduced an i2c write to put the chip into a low power m=
ode.
> > > My best guess for a cause would be that something else is incorrectly=
 being disabled
> > > before this call and hence breaking the i2c comms.
> >=20
> > Can you please try the patch here and see if the device supports
> > DISABLE command at all:
> >=20
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1988346/comments/5=
2
>=20
>=20
> I've tried it, this is the response
>=20
> tee: '/sys/bus/iio/devices/iio:device0/disable': Permission denied
>=20
> I don't think it supports the disable command
>=20
> Wahaj Javed
>=20
My apologies, loaded the unmodified kernel before. After applying the patch=
, I get the following dmesg output

- [   97.659932] iio iio:device0: CM32181_CMD_ALS_DISABLE succeeded.

Although disabling it doesn't affect the suspend timeline

- [  112.456347] sd 0:0:0:0: [sda] Synchronizing SCSI cache
  [  112.463074] cm32181 i2c-CPLM3218:00: PM: dpm_run_callback(): acpi_subs=
ys_suspend+0x0/0x60 returns -121
  [  112.463093] cm32181 i2c-CPLM3218:00: PM: failed to suspend async: erro=
r -121
  [  112.466463] sd 0:0:0:0: [sda] Stopping disk
  [  115.543097] PM: Some devices failed to suspend, or early wake event de=
tected

Wahaj Javed

> > Kai-Heng
> >=20
> > > Jonathan
> > >=20
> > > > I would like to take on this bug and try to solve it if that's poss=
ible
> > > >=20
> > > > Best Regards
> > > > Wahaj Javed
