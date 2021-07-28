Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA443D8A10
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 10:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhG1Iv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhG1Ivz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 04:51:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F054C061757;
        Wed, 28 Jul 2021 01:51:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z3so519297plg.8;
        Wed, 28 Jul 2021 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+TKoRbRA9b13s3E5XDsyBNlfB93JKDfM2toP4owP3k=;
        b=KvUOaH9qSthpAAstRMpHeQGCcFTDN1NmIU/l+62WLAgXEC162dXCLUT1TpBhTbKIVb
         pPTTyvNFJvbLXVAEsfUAAKapY8NJRvO+Oy93p7TqQLMKF2RIYxBJ+n65G+9qlbTBhJ7f
         X6LAlEqpDNeb8SVtvINW1MlUlaVQalBmz26ET0zFPc2FAvAkrT7/L6ZjPQIEtDQh2iQt
         tNKbNpOWld5sBvZCCiQ1sDCIl3uyYC3WlyfXoq/dfCTxIBkHJBCTc6D3WsJqTR5Gw8Ip
         0fyJoloduJgE3BRYKW++w50GTwTi/HrhfXhpj018OhFCzrYFn52UHntUZRBqol+WxiWR
         VX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+TKoRbRA9b13s3E5XDsyBNlfB93JKDfM2toP4owP3k=;
        b=bkwa37vww/Z6Q387KZbFoP7QrGLHEJHl6vpv7GnNIlrZ6J6DbKaPZUrShLSY2gvCWD
         NBxY4fOeG+xrW9b2wZDBE5Jv+ge7VNMzqi3c26C8WyPhI24WDxdvLo8w4Lfb58vhQfge
         7u0f+VYNC5u+6pQ3d3uKCTBLSG8G94RYz6x599nae50NG8rpKsZ2jV50+JH6WK+AIHzw
         +kgN0F6raHNjZDhds4M1YEL6SC8d7qtS5VmhS+xH3Bgfve2Tf5Qn5pA8npnbECuDI4Dl
         xzlW7oHvy7HD/NAQQiEgPGNh1I8UWrObagUJZRDTt7cXA4qKnCAL3YG+yxdGeHS5bLMi
         tIqw==
X-Gm-Message-State: AOAM530ZB3gBHwX1p4jbeqTq1cWnF+9u9/GiqC2zlrkjwsEw/ByIvkj6
        8E1swECzyHbBwuNJ/WTfBjc=
X-Google-Smtp-Source: ABdhPJyx0mJnNWFX+phIfQvzqfyvuOAsA6WOBgXvG2nP7/QmaG38jNjnfekSz8VLGi6qhLW6L6MVnw==
X-Received: by 2002:a63:ae48:: with SMTP id e8mr28523370pgp.0.1627462312753;
        Wed, 28 Jul 2021 01:51:52 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z11sm2180976pjq.13.2021.07.28.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 01:51:51 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:51:45 +0900
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
Message-ID: <YQEaoYMGdvh0vgu5@shinobu>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nBN+j+tbFwGEfQq0"
Content-Disposition: inline
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--nBN+j+tbFwGEfQq0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 06:53:04PM +0900, William Breathitt Gray wrote:
> Suppose I open the chrdev from a userspace application and keep it open,
> but then remove the respective driver and Counter subsystem module from
> my system. The devm_counter_release() and counter_exit() functions will
> be called as expected; the counter_chrdev_release() function will not be
> called yet, but that is expected because the chrdev is still open by
> userspace. If I try to break out of my userspace application, I expect
> counter_chrdev_release() to finally be called, but this does not happen.
> Instead, my userspace application stalls and I see the following error
> in my dmesg:
>=20
> [  172.859570] BUG: unable to handle page fault for address: ffffffffc09a=
e298
> [  172.859594] #PF: supervisor read access in kernel mode
> [  172.859598] #PF: error_code(0x0000) - not-present page
> [  172.859603] PGD 23615067 P4D 23615067 PUD 23617067 PMD 1029ad067 PTE 0
> [  172.859623] Oops: 0000 [#1] SMP NOPTI
> [  172.859629] CPU: 2 PID: 2485 Comm: counter_example Not tainted 5.13.0+=
 #1
> [  172.859640] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S d55cb5a 04/01/2014
> [  172.859645] RIP: 0010:filp_close+0x29/0x70
> [  172.859662] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48 8=
b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6 <=
48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
> [  172.859669] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
> [  172.859675] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 000000000=
0000001
> [  172.859680] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a438=
21f4f00
> [  172.859684] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 000000000=
0000001
> [  172.859687] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a438=
21f4f00
> [  172.859691] R13: ffff9a4382970840 R14: 0000000000000000 R15: 000000000=
0000003
> [  172.859694] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) knlG=
S:0000000000000000
> [  172.859699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  172.859704] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 000000000=
0370ee0
> [  172.859713] Call Trace:
> [  172.859730]  put_files_struct+0x73/0xd0
> [  172.859738]  exit_files+0x49/0x50
> [  172.859743]  do_exit+0x33b/0xa20
> [  172.859751]  do_group_exit+0x3b/0xb0
> [  172.859758]  get_signal+0x16f/0x8b0
> [  172.859766]  ? _copy_to_user+0x20/0x30
> [  172.859774]  ? put_timespec64+0x3d/0x60
> [  172.859784]  arch_do_signal_or_restart+0xf3/0x850
> [  172.859794]  ? hrtimer_nanosleep+0x9f/0x120
> [  172.859802]  ? __hrtimer_init+0xd0/0xd0
> [  172.859808]  exit_to_user_mode_prepare+0x122/0x1b0
> [  172.859816]  syscall_exit_to_user_mode+0x27/0x50
> [  172.859825]  do_syscall_64+0x48/0xc0
> [  172.859831]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  172.859839] RIP: 0033:0x7f07f8b9951a
> [  172.859850] Code: Unable to access opcode bytes at RIP 0x7f07f8b994f0.
> [  172.859853] RSP: 002b:00007ffc0d12c230 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000e6
> [  172.859860] RAX: fffffffffffffdfc RBX: ffffffffffffff01 RCX: 00007f07f=
8b9951a
> [  172.859863] RDX: 00007ffc0d12c2b0 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  172.859867] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffc0=
d12c1c6
> [  172.859871] R10: 00007ffc0d12c2b0 R11: 0000000000000246 R12: 00007ffc0=
d12c2b0
> [  172.859874] R13: 00007ffc0d12c2b0 R14: 0000000000000000 R15: 000000000=
0000000
> [  172.859886] Modules linked in: intel_rapl_msr intel_rapl_common kvm_in=
tel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel nls_iso8859_1 aes=
ni_intel crypto_simd cryptd rapl drm_ttm_helper ttm uvcvideo drm_kms_helper=
 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common input_l=
eds syscopyarea videodev sysfillrect sysimgblt fb_sys_fops cec rc_core joyd=
ev mc drm serio_raw mac_hid qemu_fw_cfg sch_fq_codel msr parport_pc ppdev l=
p parport virtio_rng ip_tables x_tables autofs4 hid_generic usbhid hid virt=
io_net psmouse net_failover i2c_piix4 virtio_blk failover pata_acpi floppy =
[last unloaded: counter]
> [  172.859995] CR2: ffffffffc09ae298
> [  172.860009] ---[ end trace e7d3d7da1a73b8f4 ]---
> [  172.860013] RIP: 0010:filp_close+0x29/0x70
> [  172.860021] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48 8=
b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6 <=
48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
> [  172.860027] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
> [  172.860031] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 000000000=
0000001
> [  172.860034] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a438=
21f4f00
> [  172.860038] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 000000000=
0000001
> [  172.860041] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a438=
21f4f00
> [  172.860044] R13: ffff9a4382970840 R14: 0000000000000000 R15: 000000000=
0000003
> [  172.860047] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) knlG=
S:0000000000000000
> [  172.860052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  172.860056] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 000000000=
0370ee0
> [  172.860073] Fixing recursive fault but reboot is needed!
>=20
> It looks like faults in filp_close() before counter_chrdev_release() is
> called. Is this issue manifesting because counter_exit() was called
> earlier while the chrdev was still open?

After giving this some more thought I realized that once the counter
module is unloaded, the counter_fops callbacks are lost and thus the
fops for the chrdev are no longer be valid. This means that
counter_chrdev_release will need to be called before the counter module
is unloaded. How can I guarantee this if a userspace application may
still have the chrdev indefinitely open? In counter_chrdev_remove(),
should I walk through the open chrdevs and release each one?

William Breathitt Gray

--nBN+j+tbFwGEfQq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmEBGqEACgkQhvpINdm7
VJK61hAAwX6ZbCIqTphv+RPqSJYQLjl29hER5BUiwApvZiyLtZTthDW4QmozpLZP
La5uZLLqeAIpdEXvMhuyrS50KRFwPNmCVckPM6NCXhSv5nNpFmgXzd44dGtstSWd
t5djVKZQkjgoUyC2dL6K49E3cfjDIXL8Az5igoBz04rcr4hmMY/lOu64m8DEJGiC
28j5h7tD3Xc1mvyn5H7l//XnCOZOx2lIbPN26tcg8sFGB8GrdD9MbsAwFaQCdwTr
g4IDLk49NJKEeKM5Psyq24ZpqdN1psDNBbm6oYw8WjITwvQuNjrxTsZU9b1Gu42r
jck0wEc2yJBDBUBKscFNpE/+kgadohVHPVCGLxT2/+Y7vUadMiJmLQYQsgW+b17e
rYx5aDId8xBGlegsNKlYJSc6iI1Uf4BUHUzPT97QCW48Ni3dH6LWtcZoamdh3FSa
1hsVCDcY/+clrNNRs1cdBNyeaPPI7szN3b3joDw97eglJ9yzyajW8+EtGwdIJUVG
6BUgmFUiLRl/TlYyGw6FCKZO3OX5thj2TKp+0WXddBfgYwTIMrOQG2EQSKx2wxnb
CjKQlHsugDMdtyEH3vgVv0kZHyFn7eKUYrnCfTPFX4I16jcsqaNynxqF/SQPwTwg
EJJoBWJf92lhnNMHuN/e0w9XzZTO7dbx6bR7vV26sHLFScU+fqg=
=QXPz
-----END PGP SIGNATURE-----

--nBN+j+tbFwGEfQq0--
