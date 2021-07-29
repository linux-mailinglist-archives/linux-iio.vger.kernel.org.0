Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE83DA089
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 11:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhG2Jst (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhG2Jss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 05:48:48 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5739C061757;
        Thu, 29 Jul 2021 02:48:44 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id x16so1170331vkn.0;
        Thu, 29 Jul 2021 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dZaS47nSlEIbF3gt+eXWvP8QryuhvxuisTCZUzClp2Q=;
        b=FZ7DowT7UzVjrl1MBVsA/uecOICDwBYScfFgxpjbdlQ1UaOgSUiRhaGl6EWoeZ0Ozf
         LWiJImWjYo+AQ0JeTJZbQSwcksgYr1k5npIaVercCOO9d6qZlBdynQR0VDt2vzhdWFcW
         qF1lNqDgXbJXMLEsJY8QBvLe9TselcXQBWTbocZ4Tlkf3/PVCa7kXv+VTtJ4tzlv1snU
         TD9LoZcrZ9NxzNlxWjg8fGYpjNIL95UL3YDYOHjZg1YwVlZSWBNvOKQm87lYAZAgrV2r
         ce6hXU82ijLx/T4CPFHB8xXAfIxwUy+QNLpY2PY8ZxF/430168BTwKeMY8pt0yJTuQDY
         eNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZaS47nSlEIbF3gt+eXWvP8QryuhvxuisTCZUzClp2Q=;
        b=G7C9+0GuNWul/ww8dCf9QV91VhYOxtr1RHKLR7sYNP7BVbadCLgvjWCUEhW2f879Oi
         OGcM0lvjTeAV6gNmHdPHP0WFVZIzH2gJi/QT/7QPfEER4JLF4G9mHmAri7C9PKddxAsI
         LhidCRbPh0U6kpiJwkGXs2eeJH1aRbaUqwAIOrnhfHJd14qO1LjTdPGD8U8gCinWWQmz
         500X9pH87E938V9k1I1g9JECHsAALAqPqygpCEDBYYJoWNV8mfkoO5Utav0bu9v0TlQ5
         CFijhZgrpFQ/lcrLh2zcjikPem7+rwz6xQIFYiWJpwOk98yrzzi5CYCQGBsiFsRXOlm0
         Z95Q==
X-Gm-Message-State: AOAM531CITYjhWjSAma2FrnOWq40uoTTNVi2baeJAQjaJyS6vDqdTs15
        uJlkVcSdKP1pvEjCl4YpPBw=
X-Google-Smtp-Source: ABdhPJzUqcQx+NYmVmOoymLqQI0/ZyOvIUerZ/7pNZ+ZNAGcv//gJwOy6a2nZW+0syEWsJT0qAF2yA==
X-Received: by 2002:a05:6122:451:: with SMTP id f17mr3080938vkk.22.1627552123975;
        Thu, 29 Jul 2021 02:48:43 -0700 (PDT)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id q188sm112686vkq.13.2021.07.29.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 02:48:43 -0700 (PDT)
Date:   Thu, 29 Jul 2021 18:48:35 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v13 00/17] Introduce the Counter character device
 interface
Message-ID: <YQJ5c5+wWlmubxaG@shinobu>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
 <YQEaoYMGdvh0vgu5@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TqnZt1+pCWg0OOJI"
Content-Disposition: inline
In-Reply-To: <YQEaoYMGdvh0vgu5@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TqnZt1+pCWg0OOJI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2021 at 05:51:45PM +0900, William Breathitt Gray wrote:
> On Tue, Jul 13, 2021 at 06:53:04PM +0900, William Breathitt Gray wrote:
> > Suppose I open the chrdev from a userspace application and keep it open,
> > but then remove the respective driver and Counter subsystem module from
> > my system. The devm_counter_release() and counter_exit() functions will
> > be called as expected; the counter_chrdev_release() function will not be
> > called yet, but that is expected because the chrdev is still open by
> > userspace. If I try to break out of my userspace application, I expect
> > counter_chrdev_release() to finally be called, but this does not happen.
> > Instead, my userspace application stalls and I see the following error
> > in my dmesg:
> >=20
> > [  172.859570] BUG: unable to handle page fault for address: ffffffffc0=
9ae298
> > [  172.859594] #PF: supervisor read access in kernel mode
> > [  172.859598] #PF: error_code(0x0000) - not-present page
> > [  172.859603] PGD 23615067 P4D 23615067 PUD 23617067 PMD 1029ad067 PTE=
 0
> > [  172.859623] Oops: 0000 [#1] SMP NOPTI
> > [  172.859629] CPU: 2 PID: 2485 Comm: counter_example Not tainted 5.13.=
0+ #1
> > [  172.859640] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS d55cb5a 04/01/2014
> > [  172.859645] RIP: 0010:filp_close+0x29/0x70
> > [  172.859662] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48=
 8b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6=
 <48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
> > [  172.859669] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
> > [  172.859675] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 0000000=
000000001
> > [  172.859680] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a4=
3821f4f00
> > [  172.859684] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 0000000=
000000001
> > [  172.859687] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a4=
3821f4f00
> > [  172.859691] R13: ffff9a4382970840 R14: 0000000000000000 R15: 0000000=
000000003
> > [  172.859694] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) kn=
lGS:0000000000000000
> > [  172.859699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  172.859704] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 0000000=
000370ee0
> > [  172.859713] Call Trace:
> > [  172.859730]  put_files_struct+0x73/0xd0
> > [  172.859738]  exit_files+0x49/0x50
> > [  172.859743]  do_exit+0x33b/0xa20
> > [  172.859751]  do_group_exit+0x3b/0xb0
> > [  172.859758]  get_signal+0x16f/0x8b0
> > [  172.859766]  ? _copy_to_user+0x20/0x30
> > [  172.859774]  ? put_timespec64+0x3d/0x60
> > [  172.859784]  arch_do_signal_or_restart+0xf3/0x850
> > [  172.859794]  ? hrtimer_nanosleep+0x9f/0x120
> > [  172.859802]  ? __hrtimer_init+0xd0/0xd0
> > [  172.859808]  exit_to_user_mode_prepare+0x122/0x1b0
> > [  172.859816]  syscall_exit_to_user_mode+0x27/0x50
> > [  172.859825]  do_syscall_64+0x48/0xc0
> > [  172.859831]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  172.859839] RIP: 0033:0x7f07f8b9951a
> > [  172.859850] Code: Unable to access opcode bytes at RIP 0x7f07f8b994f=
0.
> > [  172.859853] RSP: 002b:00007ffc0d12c230 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000e6
> > [  172.859860] RAX: fffffffffffffdfc RBX: ffffffffffffff01 RCX: 00007f0=
7f8b9951a
> > [  172.859863] RDX: 00007ffc0d12c2b0 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [  172.859867] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff=
c0d12c1c6
> > [  172.859871] R10: 00007ffc0d12c2b0 R11: 0000000000000246 R12: 00007ff=
c0d12c2b0
> > [  172.859874] R13: 00007ffc0d12c2b0 R14: 0000000000000000 R15: 0000000=
000000000
> > [  172.859886] Modules linked in: intel_rapl_msr intel_rapl_common kvm_=
intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel nls_iso8859_1 a=
esni_intel crypto_simd cryptd rapl drm_ttm_helper ttm uvcvideo drm_kms_help=
er videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common input=
_leds syscopyarea videodev sysfillrect sysimgblt fb_sys_fops cec rc_core jo=
ydev mc drm serio_raw mac_hid qemu_fw_cfg sch_fq_codel msr parport_pc ppdev=
 lp parport virtio_rng ip_tables x_tables autofs4 hid_generic usbhid hid vi=
rtio_net psmouse net_failover i2c_piix4 virtio_blk failover pata_acpi flopp=
y [last unloaded: counter]
> > [  172.859995] CR2: ffffffffc09ae298
> > [  172.860009] ---[ end trace e7d3d7da1a73b8f4 ]---
> > [  172.860013] RIP: 0010:filp_close+0x29/0x70
> > [  172.860021] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48=
 8b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6=
 <48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
> > [  172.860027] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
> > [  172.860031] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 0000000=
000000001
> > [  172.860034] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a4=
3821f4f00
> > [  172.860038] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 0000000=
000000001
> > [  172.860041] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a4=
3821f4f00
> > [  172.860044] R13: ffff9a4382970840 R14: 0000000000000000 R15: 0000000=
000000003
> > [  172.860047] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) kn=
lGS:0000000000000000
> > [  172.860052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  172.860056] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 0000000=
000370ee0
> > [  172.860073] Fixing recursive fault but reboot is needed!
> >=20
> > It looks like faults in filp_close() before counter_chrdev_release() is
> > called. Is this issue manifesting because counter_exit() was called
> > earlier while the chrdev was still open?
>=20
> After giving this some more thought I realized that once the counter
> module is unloaded, the counter_fops callbacks are lost and thus the
> fops for the chrdev are no longer be valid. This means that
> counter_chrdev_release will need to be called before the counter module
> is unloaded. How can I guarantee this if a userspace application may
> still have the chrdev indefinitely open? In counter_chrdev_remove(),
> should I walk through the open chrdevs and release each one?
>=20
> William Breathitt Gray

Sorry for all the noise, I had simply forgotten to define the owner
member of counter_fops structure to THIS_MODULE. I'll make that fix and
also add in some conditional checks to protect the callbacks so they
return -ENODEV if the counter has been unregistered. With that I expect
to have a v14 submission ready some time this coming week.

William Breathitt Gray

--TqnZt1+pCWg0OOJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmECeWkACgkQhvpINdm7
VJLWPw/9Gvy1Am3dCnOtIeE+VRrEZ+PD6w4p3uhoBgBNRSDbHOM3TAAYynG1myLB
CgV1I8EwG9TEMWXp2EoxjrQr8HgsblGjBwm+qnKO4MAEldms2HEHknaZL2h9/T2/
TIIXC6Be5egf3zH9dZ2BmbtSN1A6qlJ1384CThpO8XE3aINjL8ye4N5TjQp3UuPT
sRrkQJnzsQ7lX1IuLmIgLqd8/SGC5+QBYSTLLIUmxQd5UBXEEqKsSM2FzUmRc6XN
SjTWgWOKcGcrN87gz/ZnCexTXN6QZ0Hv27N6EiHN0CsOlRCib01PiVXhNneGw8uL
0jG0zyOLE5RLDv0gpwh+qz2JuZGSPenZjHnxp6ipWM4gMuCs0da1+4gR4UFA98m9
HH7L5qJy2vA7thqcfAqbxtAWX+NvG225cZlmcqBYrYGhJZXoxjZgfiw5NrA0onLN
Q2XBsDr6Oix6CfKpP6YLphbHaZjV++HoCrX83helg6Kry89yJMRMfjPmxUbZYdJC
g9EhcihevOUjs+ftvkAaVI2fkhKPOyA8WGmU3/Ft3XI9PA82dKxeUSsZrWIM3Q8w
PlJE87GMBWgXx6oO9+2N9epIlMhvBNXa6TY382Q8zrbrGWJfp9S6PD0BZUx3boJl
rU7B2AktQWrJFenBZ/Ryy0RSzzDrjnQ9T2cwvtEA2TFYb0LGlzw=
=PKVq
-----END PGP SIGNATURE-----

--TqnZt1+pCWg0OOJI--
