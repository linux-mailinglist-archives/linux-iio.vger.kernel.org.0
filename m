Return-Path: <linux-iio+bounces-26446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675CC82D21
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2404E4E65E9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4509318120;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXCua3HT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E02F99AD;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=WY46Ujy1hk92A0VoGDISUMXHEyUyM7lzTpCJ8X9AKO7WMxUmCrAn2r3Va4SnqciiwuMoAqDD4C39u5pcHnIeKLwNdkWOL5GRB8w2mzpEibCpkDU9XUIh+I+QbX3R29s7b5KdjCY3RLYs8jNcu+oPiOr0RY/4WeADKNlGr9xb4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=ZN9YEjm4mofiujKDjvY5bJVbyw6A3uPr9UwEVdbcyaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AixDn9b1WLvGh3RSlE1pLYdieDRgFCKCWs3R1/UXQvGR4/91D3nFl+RK+GEL8jbbnpCjyf2hmBR1VGX9+K85bOeDzR8ga6FLHurvZJFZkHc4TQsUo6Mtp9wU6aFQFoyaEhkrDMhkkW0C2LRYfSS9NFKYnvjc5GKGUn9yrxHlG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXCua3HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D75E1C2BCC4;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=ZN9YEjm4mofiujKDjvY5bJVbyw6A3uPr9UwEVdbcyaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WXCua3HTZ7wdvFD69MSPEDR8uuiQByNDMx75l+D7ffF9aVxGe8MAcfZN5+ErfrkTv
	 QJdSKUAkjFsiz5jD+bmB0s88fxyE9SOcxrh1LnFl5qTFO2g7F1d0vaCUXyLgCA6Dkn
	 gxkm/e8VmuinVz25mrB/qd/AkfzaG0y0lD72RAcat9RwvClZ1r/iqmESdGJsmAJ5NQ
	 +eVVyMeBiLzXjpe4jYN1PAjQSnsfPfUD3DcuzX78OufNQ8QCTXJF4lOUYygTPYUMXv
	 1MQFjIMYvxOuEnz0e28knD2TBtv2Qlk6KI0SZz360LhzAfpTWIFPA92+tugwv57GCt
	 ufJUGhOlkAKuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA177CFD36B;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:26 -0800
Subject: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
In-Reply-To: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=5921;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=/ZZEHlCaeeU7A42iJsRUFkp4UqWiRDldJmkxQPFbnH0=;
 b=A+lLK0JUvVziv2HOc9b02v9thpQpJbmn7U5VaoFim+npy26emvE/zZHAiJyCOAMaPXAdyWCYo
 o1iqNHPR+I/CsjZUNUmhGCRPPWBr9k1SPVhe+CO+BR6c4nsnYS48sFS
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

The bmc150_accel_set_interrupt() function assumes that the interrupt
info is provided. However, when no IRQ is provided, the info pointer
remains NULL, leading to a kernel oops:

	[   95.444148] 8<--- cut here ---
	[   95.444202] Unable to handle kernel NULL pointer dereference at virtual address 00000001 when read
	[   95.451504] [00000001] *pgd=00000000
	[   95.459997] Internal error: Oops: 5 [#1] SMP ARM
	[   95.460059] Modules linked in: nf_tables atmel_mxt_ts pn544_i2c crc_ccitt pn544 hci nfc rfkill tsl2772 qcom_rng zram zsmalloc fuse loop nfnetlink ext4 jbd2 dm_mod
	[   95.463738] CPU: 0 UID: 0 PID: 568 Comm: iio-sensor-prox Not tainted 6.18.0-rc6-00107-g56ee44ac80c9 #2 PREEMPT
	[   95.478046] Hardware name: Generic DT based system
	[   95.488019] PC is at bmc150_accel_set_interrupt+0x98/0x194
	[   95.492879] LR is at __pm_runtime_resume+0x5c/0x64
	[   95.498345] pc : [<c0bbadb4>]    lr : [<c0902474>]    psr: 60000013
	[   95.503124] sp : f09dddc0  ip : 00240024  fp : c1febb58
	[   95.509284] r10: c1e0b270  r9 : 00000100  r8 : c104f4f4
	[   95.514492] r7 : c35b6420  r6 : 00000000  r5 : 00000001  r4 : c1e0b380
	[   95.519704] r3 : 00250024  r2 : 00000025  r1 : 00000000  r0 : 00000000
	[   95.526298] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
	[   95.532812] Control: 10c5787d  Table: 8447006a  DAC: 00000051
	[   95.540011] Register r0 information: NULL pointer
	[   95.545743] Register r1 information: NULL pointer
	[   95.550427] Register r2 information: non-paged memory
	[   95.555115] Register r3 information: non-paged memory
	[   95.560152] Register r4 information: slab kmalloc-2k start c1e0b000 pointer offset 896 size 2048
	[   95.565195] Register r5 information: non-paged memory
	[   95.574038] Register r6 information: NULL pointer
	[   95.578989] Register r7 information: slab kmalloc-1k start c35b6400 pointer offset 32 size 1024
	[   95.583680] Register r8 information: non-slab/vmalloc memory
	[   95.592183] Register r9 information: non-paged memory
	[   95.598083] Register r10 information: slab kmalloc-2k start c1e0b000 pointer offset 624 size 2048
	[   95.603039] Register r11 information: slab kmalloc-192 start c1febb40 pointer offset 24 size 192
	[   95.611896] Register r12 information: non-paged memory
	[   95.620743] Process iio-sensor-prox (pid: 568, stack limit = 0x91dd47d2)
	[   95.625692] Stack: (0xf09dddc0 to 0xf09de000)
	[   95.632558] ddc0: 60000013 c104f4f4 00000100 c1e0b270 c1e0b3e4 c1e0b380 00000000 00000004
	[   95.636813] dde0: c1febb58 c0bbb32c c1e0b270 c1e0b000 c1febb40 00000004 c1febb58 c0bb5df0
	[   95.644978] de00: b6985148 00000001 c1e0b270 00000001 c104f4f4 c06a37a0 c1febba4 00000004
	[   95.653138] de20: c1e0b000 00000001 c1e0b234 c1febb40 c1e0b008 f09dde90 c2751f00 c4901048
	[   95.661294] de40: b6985148 c0bb7874 019dde90 99e880ae c48fe300 fffffff2 c48fe310 00000001
	[   95.669452] de60: b6985148 c04882c8 00000000 00000000 00000000 f09dde90 00004004 00000004
	[   95.677619] de80: 00000000 f09ddf78 b6985148 c03e1130 c4901000 00000000 00000000 00000000
	[   95.685773] dea0: 00000000 00000000 00000000 00004004 00000000 00000000 00000000 99e880ae
	[   95.693931] dec0: c4901000 c2bae880 00000002 00000002 f09ddf78 00000000 b6985148 c03e3208
	[   95.702093] dee0: 00000000 f09ddef0 000b6985 b6985000 00010001 00000000 f09ddf18 00000000
	[   95.710253] df00: 00000001 00000000 00000000 00000000 bed7e988 00000001 00000000 00000000
	[   95.718421] df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	[   95.726576] df40: 00000000 00000000 00000000 00000000 bed7e8d8 99e880ae c4901003 c4901000
	[   95.734731] df60: f09ddf78 bed7e8d8 00000002 c03e3010 00000000 c2bae880 00000000 00000000
	[   95.742894] df80: 00000092 99e880ae bed7e8d8 00000001 00000002 00000092 c01002c4 c2bae880
	[   95.751054] dfa0: 00000092 c01002b4 bed7e8d8 00000001 00000009 bed7e8d8 00000002 00000000
	[   95.759214] dfc0: bed7e8d8 00000001 00000002 00000092 b69850b0 00000001 00000001 b6985148
	[   95.767377] dfe0: ffffffff bed7e8d8 b6f5ac69 b6f58ee6 00000030 00000009 00000000 00000000
	[   95.775524] Call trace:
	[   95.775546]  bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
	[   95.786288]  bmc150_accel_buffer_postenable from __iio_update_buffers+0xb78/0xdf4
	[   95.794018]  __iio_update_buffers from enable_store+0x88/0xc8
	[   95.801562]  enable_store from kernfs_fop_write_iter+0x154/0x1b4
	[   95.807295]  kernfs_fop_write_iter from do_iter_readv_writev+0x174/0x1dc
	[   95.813369]  do_iter_readv_writev from vfs_writev+0x18c/0x428
	[   95.820051]  vfs_writev from do_writev+0x74/0xe0
	[   95.825690]  do_writev from __sys_trace_return+0x0/0x10
	[   95.830376] Exception stack(0xf09ddfa8 to 0xf09ddff0)
	[   95.835331] dfa0:                   bed7e8d8 00000001 00000009 bed7e8d8 00000002 00000000
	[   95.840547] dfc0: bed7e8d8 00000001 00000002 00000092 b69850b0 00000001 00000001 b6985148
	[   95.848702] dfe0: ffffffff bed7e8d8 b6f5ac69 b6f58ee6
	[   95.856863] Code: e1a01005 ebffffa8 e3500000 4a000020 (e5d62001)
	[   95.862186] ---[ end trace 0000000000000000 ]---

Add a check to return -ENODEV if no interrupt is provided.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3c5d1560b163..ec87901cf66a 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -523,6 +523,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	const struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	if (!info)
+		return -ENODEV;
+
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;

-- 
2.52.0



