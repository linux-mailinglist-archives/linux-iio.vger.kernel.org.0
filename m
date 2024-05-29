Return-Path: <linux-iio+bounces-5433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616428D356C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D971C229C0
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B217A938;
	Wed, 29 May 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv6WbXih"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342514A4C3;
	Wed, 29 May 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981813; cv=none; b=AG7FFZxlxD7PQsJIO8vLz3srLENn0RmeJiAlv/uxq748n0/jeqm/S/kMh63sGYTu2HjkMAIcWE5zVK2jo7gHgmChBNVC9fthywJVODDP3h6EwiWxeuQldoJrt97iSLY843vHfPNQ13Ynk2tHlBaZHQbfA7qHA8UJ2aU4Dnjn+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981813; c=relaxed/simple;
	bh=UyDiDTkkFwNigth+jfdAAEnb732HcGS6eumFWcZosys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gvefo51egYR1yATDosj2TNuYcFPKslqIhpVi2wFv74hQcKxpnLJi5b2E1pMM14bQZY7eXDiZ48v3n/DK94xW6H+H2Cs4Z+PZNaQrzGURaawvoiFatxYljlc5uTB6Owr5iX0KnN8s0nHXZqHN3RRMeMa8uHmrDbgMJkhyXdp97QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv6WbXih; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578676a1b57so890540a12.3;
        Wed, 29 May 2024 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716981810; x=1717586610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyDiDTkkFwNigth+jfdAAEnb732HcGS6eumFWcZosys=;
        b=Zv6WbXihM0AQZg1LOWsTqo4hLiDsIyU73eOwAqFd4oOOoYmOZ0uVDNRBOGuF6AKYpG
         R8swO2SfZhKqDQHnhbvQyioD3h71Mb7qbTfc2rl0gOTNV/R4zvJt8guvpYrF1GmWg0ak
         7ta0T9OmL+tW33zjN4w1LI5HNXIpYO7kXlO8XTT3kMWPEIqUqQ/PO1yAYxEBM1KXKrLp
         BjuwDhikkGLYEyg6npo+Zu6yukvSszmnEcdrQ+1vUm343we3OUtorP1iMMWAmOcVnm+L
         2OgycEcOgNtXiIcNFlwJ6eQMybB97vg2FTTvWWGbexrcxmC9ynixcjt4igCWzOo+VoMx
         wdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981810; x=1717586610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyDiDTkkFwNigth+jfdAAEnb732HcGS6eumFWcZosys=;
        b=cWqM6mNUJ0d0XFxOZYijfPz6ndwjOQ1/mk0KnuLMOMiUeZM91e107kS3ziLEeZ++gX
         U8VCXUDHW1FDf5p/7olka1c92xAOo1FYhIurfWuNeXEOOSammzwM20TEWlW4IwvxJKE2
         OmOOnraoMoxThU+ooYRs39CDGoJGzebFlhlv93qsyPXgeIuNOfgZ/p+er3Nji59GPCH2
         sTRiabTy2Kd7Aykxt2qNoIwbQ7/MCy6xSbBHAJrxxUqgiYWUX7k7dd/x6yT+uuWLlmRP
         D/jp5HrhdzFJWjuhg2J2mNZUlUGAqPjRFgfvFKa8jXn2GsqKjgr+42XGjExXs6F9GZE+
         M/bA==
X-Forwarded-Encrypted: i=1; AJvYcCVjg4cF9GNtaXqojEoMaFzYpvBq7TbVU6jvrGzevkeuYxbASGZnG8m77qoRdAvBDPmclNfCbSb8KapAk9FjEu13WAE/gYs3i1KJAPrD
X-Gm-Message-State: AOJu0YyMP10KgxaXGRpSFrxMA3599at6IPMn9DV8K8F1YBsUIWvURvzG
	5cWiQgwfPaO/nMqDh5RxOL7hEuitMmBPcS8vJNMUwmCSRKEAlcxXZDHegY5Z
X-Google-Smtp-Source: AGHT+IGSdVHF7ZdPJOT+Fx7L2ZONC3OD0PjgykcTFlUnSad5tQAYbt02jdBG0VjLsLE5R+1MVbAnLQ==
X-Received: by 2002:a50:c907:0:b0:572:689f:6380 with SMTP id 4fb4d7f45d1cf-578519144e9mr12216573a12.3.1716981809729;
        Wed, 29 May 2024 04:23:29 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d6270bd2sm3709239a12.73.2024.05.29.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 04:23:29 -0700 (PDT)
Message-ID: <5555dbdecd75f378b6e449c55dbf53dc1934566b.camel@gmail.com>
Subject: Re: [PATCH] driver: iio: add missing checks on iio_info's callback
 access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 May 2024 13:23:29 +0200
In-Reply-To: <20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com>
References: <20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 12:07 +0200, Julien Stephan wrote:
> Some callbacks from iio_info structure are accessed without any check, so
> if a driver doesn't implement them trying to access the corresponding
> sysfs entries produce a kernel oops such as:
>=20
> [ 2203.527791] Unable to handle kernel NULL pointer dereference at virtua=
l address
> 00000000 when execute
> [ 2203.535795] [00000000] *pgd=3D01e70831, *pte=3D00000000, *ppte=3D00000=
000
> [ 2203.540822] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
> [ 2203.552078] CPU: 0 PID: 1286 Comm: cat Not tainted 6.9.0-rc5-ad7380x-m=
ainline-
> g9bf895a40063-dirty #226
> [ 2203.560079] Hardware name: Xilinx Zynq Platform
> [ 2203.563300] PC is at 0x0
> [ 2203.564523] LR is at iio_read_channel_info_avail+0x48/0xd8
> [ 2203.568716] pc : [<00000000>]=C2=A0=C2=A0=C2=A0 lr : [<c07b52e4>]=C2=
=A0=C2=A0=C2=A0 psr: a0000013
> [ 2203.573672] sp : e0bade60=C2=A0 ip : 5e861799=C2=A0 fp : 00000001
> [ 2203.577586] r10: c2dcd298=C2=A0 r9 : 00400cc0=C2=A0 r8 : c2dc6000
> [ 2203.581501] r7 : c4339008=C2=A0 r6 : c2dc6000=C2=A0 r5 : 00000000=C2=
=A0 r4 : c1003fc8
> [ 2203.586718] r3 : e0bade70=C2=A0 r2 : e0bade68=C2=A0 r1 : bf00ac88=C2=
=A0 r0 : c4339000
> [ 2203.591935] Flags: NzCv=C2=A0 IRQs on=C2=A0 FIQs on=C2=A0 Mode SVC_32=
=C2=A0 ISA ARM=C2=A0 Segment none
> [ 2203.597761] Control: 18c5387d=C2=A0 Table: 01db804a=C2=A0 DAC: 0000005=
1
> [ 2203.602194] Register r0 information: slab kmalloc-1k start c4339000 po=
inter
> offset 0 size 1024
> [ 2203.609520] Register r1 information: 2-page vmalloc region starting at
> 0xbf00a000 allocated at load_module+0x704/0x1954
> [ 2203.619016] Register r2 information: 2-page vmalloc region starting at
> 0xe0bac000 allocated at kernel_clone+0xb8/0x368
> [ 2203.628417] Register r3 information: 2-page vmalloc region starting at
> 0xe0bac000 allocated at kernel_clone+0xb8/0x368
> [ 2203.637808] Register r4 information: non-slab/vmalloc memory
> [ 2203.642166] Register r5 information: NULL pointer
> [ 2203.645559] Register r6 information: slab kmalloc-4k start c2dc6000 po=
inter
> offset 0 size 4096
> [ 2203.652886] Register r7 information: slab kmalloc-1k start c4339000 po=
inter
> offset 8 size 1024
> [ 2203.660211] Register r8 information: slab kmalloc-4k start c2dc6000 po=
inter
> offset 0 size 4096
> [ 2203.667537] Register r9 information: non-paged memory
> [ 2203.671278] Register r10 information: slab vm_area_struct start c2dcd2=
80 pointer
> offset 24 size 80
> [ 2203.678951] Register r11 information: non-paged memory
> [ 2203.682779] Register r12 information: non-paged memory
> [ 2203.686607] Process cat (pid: 1286, stack limit =3D 0x354430a3)
> [ 2203.691052] Stack: (0xe0bade60 to 0xe0bae000)
> [ 2203.694105] de60: e0bade6c 00000019 c105fe40 00000001 00000002 5e86179=
9 c4309ec0
> c07b529c
> [ 2203.700979] de80: c411b200 c051f1e4 c0b48d30 c2dcd280 c411b200 c02c1fb=
8 c2dcd280
> 00020000
> [ 2203.707853] dea0: e0badf20 c0b12d88 7ffff000 c026c944 c1003fc8 0000000=
0 c2dcd2a8
> e0badf08
> [ 2203.714728] dec0: b6eaa000 c0206480 00000001 e0badfb0 c2dcda00 c1003fc=
8 c1e46d80
> c02c0ba0
> [ 2203.721602] dee0: c0b12d88 e0badf78 b6eab000 00000000 00000000 c024011=
4 00000a55
> c1dbadb8
> [ 2203.728476] df00: c1dbadb8 00000000 00000000 00000000 b6eab000 0002000=
0 00000001
> 00000000
> [ 2203.735342] df20: c1e46d80 00000000 00000000 00000000 00000000 0000000=
0 00000000
> 00000000
> [ 2203.742208] df40: 00000000 00000000 00000000 5e861799 c1003fc8 c1003fc=
8 c1e46d80
> 00000000
> [ 2203.749074] df60: 00000000 c1e46d80 b6eab000 00020000 00000000 c0240a8=
0 00000000
> 00000000
> [ 2203.755949] df80: 00028008 5e861799 00000003 b6f10f80 7ff00000 0000000=
3 c01002c4
> c6716e80
> [ 2203.762814] dfa0: 00000003 c0100060 00000003 b6f10f80 00000003 b6eab00=
0 00020000
> 00000000
> [ 2203.769680] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 0000000=
0 00020000
> 00000000
> [ 2203.776546] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0 60000010 0000000=
3 00000000
> 00000000
> [ 2203.783416] Call trace:
> [ 2203.783429]=C2=A0 iio_read_channel_info_avail from dev_attr_show+0x18/=
0x48
> [ 2203.789807]=C2=A0 dev_attr_show from sysfs_kf_seq_show+0x90/0x120
> [ 2203.794181]=C2=A0 sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
> [ 2203.798555]=C2=A0 seq_read_iter from vfs_read+0x238/0x2a0
> [ 2203.802236]=C2=A0 vfs_read from ksys_read+0xa4/0xd4
> [ 2203.805385]=C2=A0 ksys_read from ret_fast_syscall+0x0/0x54
> [ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
> [ 2203.812880] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000003 b6f10f80=
 00000003 b6eab000 00020000
> 00000000
> [ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 0000000=
0 00020000
> 00000000
> [ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
> [ 2203.830363] Code: bad PC value
> [ 2203.832695] ---[ end trace 0000000000000000 ]---
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

I think you should crop the splat on the commit message only with the perti=
nent info.
With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



