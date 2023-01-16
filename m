Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72966D1C2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 23:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjAPWZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 17:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjAPWZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 17:25:53 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F09EDC
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 14:25:51 -0800 (PST)
Date:   Mon, 16 Jan 2023 22:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673907948; x=1674167148;
        bh=ULJR7Jim/Kws3o0OvqOFEL8+QsKlh9bQQOoMvEXTWqg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=THLAtvrYDFZglgPQlq+xCo+pT6xwzHs9/cerf68o0LsnLRjEbnN+AldThzKDxwXB4
         7j56zvMXqblgKpuAdDv/vj7WtEd9VphXqWlVOn0qO2KI1jc4P19Zt33ZhM2j5VoEsc
         nmlXqaMHw0AV+cA1hLg0YZi9l3rcGtYVZm+CUJgPzp7mC8qANGiw2v6QREu3F8AykA
         KZ2rumS+SRjWWOFDqoRmrpo3kEQlrn6jBFeqE46F5pJCcYZnSwnJSXaeM4lG0PTTGB
         UIUa2t8m28KP00mRSdZIiGwhK5v+nRVJgrdPVOqMO7YapWE02Y28jKYjjpPZCjJ0hD
         PEsBgjKQxgXww==
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
From:   Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <ozK9iquIv9o2or9IunOcfXJEvbVPwunC15iEe6DlT8ObOWI_wNFnJtN0lubBXEkln6pm8bp939ex7YlmEZhoxDF9nU6nKu4QkqwBkkHqJw8=@protonmail.com>
In-Reply-To: <cKYeY4HN3_NekeCl1PMBnzcn-Y64OEXNKTrGyYf3wQQekbNLzQeM5TlsB1rrGlsRSjVxnGJ84CytQ0w2VhFAoAGIrYMZnvqq0XGsnyy71L8=@protonmail.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com> <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com> <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com> <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com> <20230108124654.514a5b1b@jic23-huawei> <CAAd53p5nz0ehBmg05njKRG7cnBQQgJFpT-1oqDtajSY8Zz0NMw@mail.gmail.com> <8egyl6OawVGTgDhMmArrWCKWVTp4CxDO3jFgEMjWvk11qEyFVARwV0xoGpwBvB4CHiIVWhXth_2CKznGgCvXxFbPsrIpSwYCn_QSx4aezrk=@protonmail.com> <cKYeY4HN3_NekeCl1PMBnzcn-Y64OEXNKTrGyYf3wQQekbNLzQeM5TlsB1rrGlsRSjVxnGJ84CytQ0w2VhFAoAGIrYMZnvqq0XGsnyy71L8=@protonmail.com>
Feedback-ID: 13756336:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_AMWgd1SRvakxfeUpgceYoZgFIVDBGUoqiqBB3pspgs"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.

--b1_AMWgd1SRvakxfeUpgceYoZgFIVDBGUoqiqBB3pspgs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

------- Original Message -------
On Monday, January 16th, 2023 at 5:27 PM, Wahaj <wahajaved@protonmail.com> =
wrote:
>
>
>
> ------- Original Message -------
> On Monday, January 16th, 2023 at 3:59 PM, Wahaj wahajaved@protonmail.com =
wrote:
>
>
>
> > ------- Original Message -------
> > On Thursday, January 12th, 2023 at 5:48 AM, Kai-Heng Feng kai.heng.feng=
@canonical.com wrote:
> >
> > > Hi Wahaj,
> > >
> > > On Sun, Jan 8, 2023 at 8:33 PM Jonathan Cameron jic23@kernel.org wrot=
e:
> > >
> > > > On Sat, 07 Jan 2023 00:37:40 +0000
> > > > Wahaj wahajaved@protonmail.com wrote:
> > > >
> > > > > ------- Original Message -------
> > > > > On Friday, January 6th, 2023 at 9:08 AM, Kai-Heng Feng kai.heng.f=
eng@canonical.com wrote:
> > > > >
> > > > > > Hi Wahaj,
> > > > > >
> > > > > > On Fri, Jan 6, 2023 at 12:26 AM Wahaj wahajaved@protonmail.com =
wrote:
> > > > > >
> > > > > > > ------- Original Message -------
> > > > > > >
> > > > > > > On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron Jo=
nathan.Cameron@Huawei.com wrote:
> > > > > > >
> > > > > > > > On Wed, 28 Dec 2022 14:05:24 +0000
> > > > > > > > Wahaj wahajaved@protonmail.com wrote:
> > > > > > >
> > > > > > > > > Hi Jonathan
> > > > > > > > >
> > > > > > > > > Hope you're doing well. I have been using a laptop that c=
omes with a
> > > > > > > > > CM32181 Light Sensor and after upgrading to the Linux ker=
nel 6.0+, my
> > > > > > > > > laptop cannot seem to suspend because of the PM subsystem=
 error. I
> > > > > > > > > have narrowed the problem down to this module and I belie=
ve that the
> > > > > > > > > commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the cul=
prit
> > > > > > > > >
> > > > > > > > > The following lines were provided from the journalctl log=
s:
> > > > > > > > >
> > > > > > > > > > cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> > > > > > > > > > acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-C=
PLM3218:00:
> > > > > > > > > > PM: failed to suspend async: error -121
> > > > > > > > >
> > > > > > > > > I would love the chance to be able to work on this given =
any guidance
> > > > > > > > > on where to start
> > > > > > > >
> > > > > > > > Hi Wahaj,
> > > > > > > >
> > > > > > > > Certainly seems likely that you have identified the right c=
ommit.
> > > > > > > > As a starting point, resend this email to linux-iio@vger.ke=
rnel.org
> > > > > > > > and Kai-Heng Feng kai.heng.feng@canonical.com
> > > > > > > >
> > > > > > > > If you could try reverting the commit to be completely sure=
 it is
> > > > > > > > the cause that would help avoid any doubt.
> > > > > > > > Superficially the only thing that I can see causing this pr=
oblem is
> > > > > > > > a fail of the i2c bus write.
> > > > > > > >
> > > > > > > > Does the device work prior to suspend? Try cat /sys/bus/iio=
/iio:device0/*
> > > > > > > > and see if you get any errors (may be device1 etc)
> > > > > > > >
> > > > > > > > If the device wasn't working at all the register writes in =
probe() should
> > > > > > > > have failed so we shouldn't be trying to suspend it.
> > > > > > > > It's possible your machine has some unusual power dependenc=
ies or
> > > > > > > > similar that mean the device is getting powered down before=
 we try to
> > > > > > > > suspend it.
> > > > > > > >
> > > > > > > > Anyhow, better to have this discussion on list as there are=
 many other people
> > > > > > > > who may have more insight than me or be able to replicate a=
nd help debug.
> > > > > > > >
> > > > > > > > Jonathan
> > > > > > > >
> > > > > > > > > Best Regards,
> > > > > > > > > Wahaj Javed
> > > > > > >
> > > > > > > Hi Jonathan and Kai-Heng Feng,
> > > > > > >
> > > > > > > I am currently using the 5.15 linux kernel for a while now wh=
ich works perfectly fine.
> > > > > > >
> > > > > > > From what I gather the suspend functionality does work when u=
sing an older Linux version without the PM i2c bus writes.
> > > > > >
> > > > > > Does your system use S3 or S2idle to perform suspend?
> > > > >
> > > > > My system uses S3 to perform suspend
> > > > >
> > > > > > > The device does work fine prior to and post attempted suspend=
 with no errors showing in cat /sys/bus/iio/iio:device0/*
> > > > > >
> > > > > > Does in_illuminance_input value change after system suspend?
> > > > > > Yes, the in_illuminance_input value changes after system suspen=
d with or without the suspend and resume functions
> > > > >
> > > > > > Kai-Heng
> > > > > >
> > > > > > > Let me know if there's anything I should start looking into
> > > > > > >
> > > > > > > Best Regards
> > > > > > > Wahaj Javed
> > > > >
> > > > > How did the kernel used to suspend/resume before using the suspen=
d and resume functions in the light sensor?
> > > > >
> > > > > Was the DEFINE_SIMPLE_DEV_PM_OPS introduced as a part of the Linu=
x 6.0+ PM rework?
> > > >
> > > > Until https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
> > > > which will have hit mainline in 6.0, the driver had no suspend / re=
sume support.
> > > >
> > > > That patch introduced an i2c write to put the chip into a low power=
 mode.
> > > > My best guess for a cause would be that something else is incorrect=
ly being disabled
> > > > before this call and hence breaking the i2c comms.
> > >
> > > Can you please try the patch here and see if the device supports
> > > DISABLE command at all:
> > >
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1988346/comments=
/52
> >
> > I've tried it, this is the response
> >
> > tee: '/sys/bus/iio/devices/iio:device0/disable': Permission denied
> >
> > I don't think it supports the disable command
> >
> > Wahaj Javed
>
> My apologies, loaded the unmodified kernel before. After applying the pat=
ch, I get the following dmesg output
>
> - [ 97.659932] iio iio:device0: CM32181_CMD_ALS_DISABLE succeeded.
>
> Although disabling it doesn't affect the suspend timeline
>
> - [ 112.456347] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [ 112.463074] cm32181 i2c-CPLM3218:00: PM: dpm_run_callback(): acpi_subsy=
s_suspend+0x0/0x60 returns -121
> [ 112.463093] cm32181 i2c-CPLM3218:00: PM: failed to suspend async: error=
 -121
> [ 112.466463] sd 0:0:0:0: [sda] Stopping disk
> [ 115.543097] PM: Some devices failed to suspend, or early wake event det=
ected
>
> Wahaj Javed
>

Hi Kai-Heng

I have found some weird stuff going on while applying some changes. PFA a p=
atch for your reference

System goes to suspend, fans immediately slow down, unlike the vanilla v6.x=
 kernel, the screen doesn't wake up immediately, the fans stop spinning com=
pletely after about 4 minutes and does not wake back up along with power bu=
tton light on (not normal), have to force reboot after suspending

Here are the jounralctl logs after closing lid

- systemd[1]: Reached target Sleep.
- systemd[1]: Starting System Suspend...
- systemd-sleep[2150]: Entering sleep state 'suspend'...

The following entry only appears after the 4 minute mark when fans shut off

- kernel: PM: suspend entry (deep)

I think the issue may have something to do with how the iio device is initi=
alized. Are there any differences between the various ways of fetching the =
i2c client from the device struct?

Also, the logs do not get printed in the suspend and resume entrypoints do =
not get printed


Best Regards
Wahaj Javed

> > > Kai-Heng
> > >
> > > > Jonathan
> > > >
> > > > > I would like to take on this bug and try to solve it if that's po=
ssible
> > > > >
> > > > > Best Regards
> > > > > Wahaj Javed
--b1_AMWgd1SRvakxfeUpgceYoZgFIVDBGUoqiqBB3pspgs
Content-Type: text/x-patch; name=cm32181.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=cm32181.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIxODEuYyBiL2RyaXZlcnMvaWlvL2xp
Z2h0L2NtMzIxODEuYwppbmRleCAwMDEwNTVkMDk3NTAuLmYxOThlMzg2OWFiMyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9paW8vbGlnaHQvY20zMjE4MS5jCisrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2Nt
MzIxODEuYwpAQCAtNDkwLDE5ICs0OTAsMjkgQEAgc3RhdGljIGludCBjbTMyMTgxX3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCiAKIHN0YXRpYyBpbnQgY20zMjE4MV9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikKIHsKLQlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJj
X2NsaWVudChkZXYpOworCXN0cnVjdCBjbTMyMTgxX2NoaXAgKmNtMzIxODEgPSBpaW9fcHJpdihk
ZXZfdG9faWlvX2RldihkZXYpKTsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gY20zMjE4
MS0+Y2xpZW50OworCWludCByZXQ7CiAKLQlyZXR1cm4gaTJjX3NtYnVzX3dyaXRlX3dvcmRfZGF0
YShjbGllbnQsIENNMzIxODFfUkVHX0FERFJfQ01ELAorCWRldl9pbmZvKGRldiwgIiVzOiBFbnRl
cmVkIHN1c3BlbmQgcGF0aCBcbiIsIF9fZnVuY19fKTsKKwlyZXQgPSBpMmNfc21idXNfd3JpdGVf
d29yZF9kYXRhKGNsaWVudCwgQ00zMjE4MV9SRUdfQUREUl9DTUQsCiAJCQkJCSBDTTMyMTgxX0NN
RF9BTFNfRElTQUJMRSk7CisKKwlkZXZfaW5mbyhkZXYsICIlczogV3JpdGUgZGlzYWJsZSBjb21t
YW5kIHRvIENNMzIxODEgd2l0aCByZXR1cm4gY29kZSAlaSBcbiIsIF9fZnVuY19fLCByZXQpOwor
CXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgY20zMjE4MV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQogewotCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRl
dik7Ci0Jc3RydWN0IGNtMzIxODFfY2hpcCAqY20zMjE4MSA9IGlpb19wcml2KGRldl9nZXRfZHJ2
ZGF0YShkZXYpKTsKKwlzdHJ1Y3QgY20zMjE4MV9jaGlwICpjbTMyMTgxID0gaWlvX3ByaXYoZGV2
X3RvX2lpb19kZXYoZGV2KSk7CisJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IGNtMzIxODEt
PmNsaWVudDsKKwlpbnQgcmV0OwogCi0JcmV0dXJuIGkyY19zbWJ1c193cml0ZV93b3JkX2RhdGEo
Y2xpZW50LCBDTTMyMTgxX1JFR19BRERSX0NNRCwKKwlkZXZfaW5mbyhkZXYsICIlczogRW50ZXJl
ZCByZXN1bWUgcGF0aCBcbiIsIF9fZnVuY19fKTsKKwlyZXQgPSBpMmNfc21idXNfd3JpdGVfd29y
ZF9kYXRhKGNsaWVudCwgQ00zMjE4MV9SRUdfQUREUl9DTUQsCiAJCQkJCSBjbTMyMTgxLT5jb25m
X3JlZ3NbQ00zMjE4MV9SRUdfQUREUl9DTURdKTsKKwlkZXZfaW5mbyhkZXYsICIlczogV3JpdGUg
ZW5hYmxlIGNvbW1hbmQgdG8gQ00zMjE4MSB3aXRoIHJldHVybiBjb2RlICVpIFxuIiwgX19mdW5j
X18sIHJldCk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BN
X09QUyhjbTMyMTgxX3BtX29wcywgY20zMjE4MV9zdXNwZW5kLCBjbTMyMTgxX3Jlc3VtZSk7Cg==

--b1_AMWgd1SRvakxfeUpgceYoZgFIVDBGUoqiqBB3pspgs--

