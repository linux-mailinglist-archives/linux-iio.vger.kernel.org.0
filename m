Return-Path: <linux-iio+bounces-27129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C5CC6499
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 07:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6040300EDD0
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77125256C61;
	Wed, 17 Dec 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx63u80I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9C23ABB0
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954060; cv=none; b=YIGSjCsCH0oq6kte7LKea0Q0Wf8R416FTQsYlDY8e/u7FPLDc4S/1Jvoc4tjECW0Zv+Zr8UPRJ9VFJGYmAGcDQFLo6dtGo6myKINzxe2flApCY2f8jL0vffD01r6ICJd0LgZLBz96WJmCDhD1fTTzqWgOS+wuEOvQ+fwX7RbcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954060; c=relaxed/simple;
	bh=zoNH4pIFgLK/vLl/4K5BO5JGfpwKVGkJp2pg+JwOaiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzJ6toyjYc5YRwBonzERsUkrZf672S2pAL9R2IwOTpZfoloOeEOs8QPfWKjyIVQd0V0KZLsYOCMFN0kWE0+ZJjguxiV6nKMW+3Ajrl6pRuEgEWj3QpisLeGZ5/9TF1m0BktM2ql3reKKhV6sxComfcUJYBYlxxWpUZYctH8uRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx63u80I; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45392215f74so1973639b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 22:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765954052; x=1766558852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tobnOt0/k4PP1UYJ8wXGQviRZwJ5NKX9ZlmQIJiFe40=;
        b=jx63u80IjG85INND9ddWxdqv6zsbark1qYsK+ja3+NknQeGJDoLqVvCTecYIFP6Frm
         WqNEcc2I7b8ULJiezjX3OTwWPlV1BfP0VVz2LpGcW4+WcqGX/lDDR/2o76MjMj2GFuKJ
         cbS7lfx/iZBC9jY9V4fjl5BPXe6iA3bzcu8sI95Uh0mVVCHWQhJ9XBa2Y5ZnZ6AgqpWv
         c0A01QpiOnGJUHBByo/phW6WTZM3mCPMic2/5JmLglzKHt01klpDkqdtuxfD9jKSEWRW
         WYaBpPVcwUoqXPCJfjASKsMfxoW8tB+MyE2EYO9WxBz+WHoAnMZqaCY/su+FuJ7DKglS
         reFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765954052; x=1766558852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tobnOt0/k4PP1UYJ8wXGQviRZwJ5NKX9ZlmQIJiFe40=;
        b=YI3E50ELd1Tei4dxgg7XRCQlrmXTCn4rdsyleSr4CPEujJ5zbRA+3Y+U6Sezp9tt4g
         tfm44Zb6RUCVi6wgSQEQb2DUwdMtNMHAO5SIlFQUhtqrgOsH8EOT5caGSFrjK7cj26BA
         yJo/1/GtrXk+LRQfxVWvkd+CN5DHzhPLv4tNCNLlCuaqcLcuZW5tvujfan+20Dos+1rA
         HiitRkVnb7t4oc40NaHCt6fbZE0RrMkCrC+DqgkN1fqkOTf7unsh5+kdvgsTiEmqnZCE
         yDB99H1/cxuQvEqpq6k7m0KOB02jIfKnbCH7/VUsbrAp+Vayk3+vMU6lzR1xC3Ne3JUP
         zJnA==
X-Forwarded-Encrypted: i=1; AJvYcCXq4u/e8ni1riMzsbzRC2MaPfxR58aznRBdAzN6QEJUcNJ4yhG4Ot0AIxIYk9TohCw/u6S6xh6fsrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI8XfFhbXsFjknT3lqyyqjg7UmaTZvBcWF/eTeOq9tTWzE23+
	9n/ImxrvSFbtCKMsp5ciYp4BRij6vT1fFq0H+7NAsLXfFqvu7FTAVG0Tv+1rYoPil43XOxtvIiJ
	aEf05F584j3VVGsUw2V72s4vGqY78feM=
X-Gm-Gg: AY/fxX7Jh4orN2hH2gzCBrqBOhkNs+/2nD/UhJlRZDXknT+cCbI0zA0M/blQYastTwo
	wsY06mllJCZU9Npzy6FjXdwGQ22X95+KIkr+W6P5UurZjJHc6CAqlkflJfLM3N2ap1aMtWGYh7I
	pc1rDKvvmC4RD97fO0j2U3fn2QodhUP/vmvFYok8Bx5xw0o30+1JEt87/Hc1YO2oUTSs/8AJXmG
	G7qJ2wzlWkIMtR5nrwK6NVZvDlyyygFZouXW2lwZpe9+5AnKo0dnnjRk+XkgaCQIo0/ELo=
X-Google-Smtp-Source: AGHT+IFYcalltdWcT3nqGaUGS/eyHQDYubt+G8nJU4xXTi2ABpcZ+qsrj3+PVod3H8ztx117RVgXZ6MS6YlsNLv0m/A=
X-Received: by 2002:a05:6808:199f:b0:455:7da6:44d5 with SMTP id
 5614622812f47-455ac82425fmr7395535b6e.27.1765954051901; Tue, 16 Dec 2025
 22:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027150713.59067-1-linmq006@gmail.com> <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com> <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
 <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
 <aQDXF-AIF6wNIo76@smile.fi.intel.com> <aecd2e25900f2ef38f937a295e995269c433453b.camel@gmail.com>
 <aQDe7-ienRpcfNV_@smile.fi.intel.com>
In-Reply-To: <aQDe7-ienRpcfNV_@smile.fi.intel.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Wed, 17 Dec 2025 14:47:17 +0800
X-Gm-Features: AQt7F2pzlGRamaAGvC_lHizVPmrUNXKPjw_woO4VnnMXFdBtJxbwn9NJ3SkYBW8
Message-ID: <CAH-r-ZE0brfZ_T0tDjV5+D90V9QVLhWUO_-zvPxS7kd=LnDrWg@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Markus Burri <markus.burri@mt.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f42c790646203724"

--000000000000f42c790646203724
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I don=E2=80=99t have the actual hardware, so I built a similar demo module =
to
mirror the bug and ran it in QEMU.
With KASAN enabled, the PoC triggers BUG: KASAN: stack-out-of-bounds.

Pattern of the bug:
- A fixed 64-byte stack buffer is filled using count.
- If count > 64, the code still does buf[count] =3D '\0', causing an
out-of-bounds write on the stack.

PoC (what it does):
- Opens the device node.
- Writes 128 bytes of A to it.
- This overflows the 64-byte stack buffer and KASAN reports the stack OOB.

If you have the real device, you may run the similar PoC on your driver
to validate=E2=80=94just ensure KASAN is enabled to see the report.
I also tested the straightforward fix buf[ret] =3D '\0'; with that
change, the issue no longer reproduces.
Below are the trace, the demo module, and the PoC for reference.


[   11.824318] overflow_demo: copied 63 bytes (stack buf 64, user count 128=
)
[   11.825125] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.825806] BUG: KASAN: stack-out-of-bounds in mas_walk+0x466/0x510
[   11.825806] Write of size 8 at addr ffff888011017e48 by task
overflow_demo_p/75
[   11.825806]
[   11.825806] CPU: 0 PID: 75 Comm: overflow_demo_p Tainted: G
  O       6.6.9 #4
[   11.825806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   11.825806] Call Trace:
[   11.825806]  <TASK>
[   11.825806]  dump_stack_lvl+0x36/0x50
[   11.825806]  print_report+0xcf/0x670
[   11.825806]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   11.825806]  kasan_report+0xc7/0x100
[   11.825806]  ? mas_walk+0x466/0x510
[   11.825806]  ? mas_walk+0x466/0x510
[   11.825806]  mas_walk+0x466/0x510
[   11.825806]  ? __pfx_rebalance_domains+0x10/0x10
[   11.825806]  lock_vma_under_rcu+0xbe/0x420
[   11.825806]  ? __pfx_lock_vma_under_rcu+0x10/0x10
[   11.825806]  ? __do_softirq+0x1bf/0x5b2
[   11.825806]  ? hrtimer_interrupt+0x313/0x7c0
[   11.825806]  do_user_addr_fault+0x1c6/0x940
[   11.825806]  exc_page_fault+0x5d/0xd0
[   11.825806]  asm_exc_page_fault+0x26/0x30
[   11.825806] RIP: 0033:0x43f430
[   11.825806] Code: Unable to access opcode bytes at 0x43f406.
[   11.825806] RSP: 002b:00007ffe2f3b53b8 EFLAGS: 00000202
[   11.825806] RAX: 00007ffe2f3b53e0 RBX: 0000000000000003 RCX: 00000000000=
00002
[   11.825806] RDX: 00007ffe2f3b53c0 RSI: 0000000000486029 RDI: 00000000004=
b2320
[   11.825806] RBP: 00007ffe2f3b5490 R08: 00000000004b2820 R09: 00000000000=
00110
[   11.825806] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe2f3=
b54a0
[   11.825806] R13: 00007ffe2f3b5668 R14: 00000000004ad868 R15: 00000000000=
00001
[   11.825806]  </TASK>
[   11.825806]
[   11.825806] The buggy address belongs to stack of task overflow_demo_p/7=
5
[   11.825806]  and is located at offset 56 in frame:
[   11.825806]  lock_vma_under_rcu+0x0/0x420
[   11.825806]
[   11.825806] This frame has 1 object:
[   11.825806]  [32, 96) 'mas'
[   11.825806]
[   11.825806] The buggy address belongs to the physical page:
[   11.825806] page:(____ptrval____) refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x11017
[   11.825806] flags: 0x100000000000000(node=3D0|zone=3D1)
[   11.825806] page_type: 0xffffffff()
[   11.825806] raw: 0100000000000000 dead000000000100 dead000000000122
0000000000000000
[   11.825806] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[   11.825806] page dumped because: kasan: bad access detected
[   11.825806]
[   11.825806] Memory state around the buggy address:
[   11.825806]  ffff888011017d00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   11.825806]  ffff888011017d80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   11.825806] >ffff888011017e00: 00 00 f1 f1 f1 f1 00 00 00 f3 00 00
00 00 f3 f3
[   11.825806]                                               ^
[   11.825806]  ffff888011017e80: f3 f3 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   11.825806]  ffff888011017f00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   11.825806] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.858618] Disabling lock debugging due to kernel taint
[   11.892349] overflow_demo_p (75) used greatest stack depth: 27192 bytes =
left

Andy Shevchenko <andriy.shevchenko@intel.com> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 23:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 28, 2025 at 03:12:29PM +0000, Nuno S=C3=A1 wrote:
> > On Tue, 2025-10-28 at 16:45 +0200, Andy Shevchenko wrote:
> > > On Tue, Oct 28, 2025 at 12:31:04PM +0000, Nuno S=C3=A1 wrote:
>
> ...
>
> > > For the latter I want to see the real traceback and a reproducer. I a=
lso
> > > wonder why
> > > we never had reports from syzkaller on this. It has non-zero chance t=
o stumble
> > > over
> > > the issue here (if there is an issue to begin with).
> >
> > If I have the time, I might do it. If my suspicious are correct, it sho=
uld be
> > fairly easy to reproduce.
>
> My suspicious is also like this, if you have a working setup for one of s=
uch
> a user (like this chip) already, it's ~15 minutes to get it done without
> writing an additional code.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--000000000000f42c790646203724
Content-Type: application/octet-stream; name="overflow_demo_poc.c"
Content-Disposition: attachment; filename="overflow_demo_poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mj9ndi4x1>
X-Attachment-Id: f_mj9ndi4x1

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBTaW1wbGUgUG9D
IGZvciB0aGUgb3ZlcmZsb3dfZGVtbyBrZXJuZWwgbW9kdWxlLgogKiBCdWlsZCB3aXRoOiBnY2Mg
LVdhbGwgLU8yIC1vIG92ZXJmbG93X3BvYyBzYW1wbGVzL292ZXJmbG93X2RlbW9fcG9jLmMKICov
CgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0
ZC5oPgoKI2lmbmRlZiBUQVJHRVRfREVWSUNFCiNkZWZpbmUgVEFSR0VUX0RFVklDRSAiL2Rldi9v
dmVyZmxvd19kZW1vIgojZW5kaWYKI2RlZmluZSBQQVlMT0FEX1NJWkUgMTI4CgppbnQgbWFpbih2
b2lkKQp7CgljaGFyIHBheWxvYWRbUEFZTE9BRF9TSVpFXTsKCWludCBmZCwgcmV0OwoKCW1lbXNl
dChwYXlsb2FkLCAnQScsIHNpemVvZihwYXlsb2FkKSk7CgoJZmQgPSBvcGVuKFRBUkdFVF9ERVZJ
Q0UsIE9fV1JPTkxZKTsKCWlmIChmZCA8IDApIHsKCQlwZXJyb3IoIm9wZW4iKTsKCQlyZXR1cm4g
RVhJVF9GQUlMVVJFOwoJfQoKCXJldCA9IHdyaXRlKGZkLCBwYXlsb2FkLCBzaXplb2YocGF5bG9h
ZCkpOwoJaWYgKHJldCA8IDApIHsKCQlwZXJyb3IoIndyaXRlIik7CgkJY2xvc2UoZmQpOwoJCXJl
dHVybiBFWElUX0ZBSUxVUkU7Cgl9CgoJcHJpbnRmKCJ3cm90ZSAlZCBieXRlcyB0byAlc1xuIiwg
cmV0LCBUQVJHRVRfREVWSUNFKTsKCWNsb3NlKGZkKTsKCXJldHVybiBFWElUX1NVQ0NFU1M7Cn0K
--000000000000f42c790646203724
Content-Type: application/octet-stream; name="overflow_demo.c"
Content-Disposition: attachment; filename="overflow_demo.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mj9ndi4r0>
X-Attachment-Id: f_mj9ndi4r0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBTdGFjayBvdmVy
ZmxvdyBkZW1vIG1vZHVsZQogKgogKiBUaGlzIHNhbXBsZSBtaW1pY3MgYSByZWFsLXdvcmxkIGJ1
ZyBwYXR0ZXJuOiBhIGZpeGVkLXNpemUgc3RhY2sgYnVmZmVyIGlzCiAqIGZpbGxlZCB2aWEgc2lt
cGxlX3dyaXRlX3RvX2J1ZmZlcigpLCBidXQgdGhlIGNvZGUgdXNlcyB0aGUgdXNlci1zdXBwbGll
ZAogKiBjb3VudCB0byBwbGFjZSBhIHRlcm1pbmF0b3IsIHNvIGEgbGFyZ2UgY291bnQgY2F1c2Vz
IGEgd3JpdGUgcGFzdCB0aGUgZW5kCiAqIG9mIHRoZSBzdGFjayBidWZmZXIgZXZlbiBpZiB0aGUg
Y29weSB3YXMgdHJ1bmNhdGVkLiBEZXZpY2U6IC9kZXYvb3ZlcmZsb3dfZGVtby4KICovCgojZGVm
aW5lIHByX2ZtdChmbXQpICJvdmVyZmxvd19kZW1vOiAiIGZtdAoKI2luY2x1ZGUgPGxpbnV4L2Zz
Lmg+CiNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiNpbmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+
CiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KCiNk
ZWZpbmUgREVNT19TVEFDS19CVUZfU0laRSA2NAoKc3RhdGljIG5vaW5saW5lIHNzaXplX3Qgb3Zl
cmZsb3dfZGVtb193cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKCQkJCQkgICAgY29uc3QgY2hhciBf
X3VzZXIgKmJ1Ziwgc2l6ZV90IGxlbiwKCQkJCQkgICAgbG9mZl90ICpwcG9zKQp7CgljaGFyIGxv
Y2FsW0RFTU9fU1RBQ0tfQlVGX1NJWkVdOwoJc3NpemVfdCB3cml0dGVuOwoKCWlmICghbGVuKQoJ
CXJldHVybiAwOwoKCS8qIFZ1bG5lcmFibGUgcGF0dGVybjogY29weSBpcyBib3VuZGVkLCBidXQg
dGVybWluYXRvciB1c2VzIHVzZXIgY291bnQuICovCgl3cml0dGVuID0gc2ltcGxlX3dyaXRlX3Rv
X2J1ZmZlcihsb2NhbCwgc2l6ZW9mKGxvY2FsKSAtIDEsIHBwb3MsIGJ1ZiwKCQkJCQkgbGVuKTsK
CWlmICh3cml0dGVuIDwgMCkKCQlyZXR1cm4gd3JpdHRlbjsKCgkvKiBEaWFnbm9zdGljOiBzaG93
IHRoZSBzdGFjayBidWZmZXIgYmFzZSBhbmQgdGhlIHRlcm1pbmF0b3Igd3JpdGUgdGFyZ2V0LiAq
LwoJaWYgKGxlbiA+PSBzaXplb2YobG9jYWwpKQoJCXByX2VycigibGVuPSV6dSA+PSBidWY9JXp1
OiBsb2NhbD0lcHgsIHRlcm1pbmF0b3JfdGFyZ2V0PSVweFxuIiwKCQkgICAgICAgbGVuLCBzaXpl
b2YobG9jYWwpLCBsb2NhbCwgbG9jYWwgKyBsZW4pOwoJZWxzZQoJCXByX2luZm8oImxlbj0lenUg
PCBidWY9JXp1OiBsb2NhbD0lcHgsIHRlcm1pbmF0b3JfdGFyZ2V0PSVweFxuIiwKCQkgICAgICAg
bGVuLCBzaXplb2YobG9jYWwpLCBsb2NhbCwgbG9jYWwgKyBsZW4pOwoKCS8qIEJVRzogbGVuIG1h
eSBleGNlZWQgbG9jYWwgc2l6ZTsgdGhpcyBPT0Igd3JpdGUgbWltaWNzIHRoZSByZWFsIGlzc3Vl
LiAqLwoJbG9jYWxbbGVuXSA9ICdcMCc7CgoJcHJfaW5mbygiY29waWVkICV6ZCBieXRlcyAoc3Rh
Y2sgYnVmICV6dSwgdXNlciBjb3VudCAlenUpXG4iLCB3cml0dGVuLAoJCXNpemVvZihsb2NhbCks
IGxlbik7CgoJcmV0dXJuIHdyaXR0ZW47Cn0KCnN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIG92ZXJmbG93X2RlbW9fZm9wcyA9IHsKCS5vd25lciA9IFRISVNfTU9EVUxFLAoJLndy
aXRlID0gb3ZlcmZsb3dfZGVtb193cml0ZSwKfTsKCnN0YXRpYyBzdHJ1Y3QgbWlzY2RldmljZSBv
dmVyZmxvd19kZW1vX21pc2NkZXYgPSB7CgkubWlub3IgPSBNSVNDX0RZTkFNSUNfTUlOT1IsCgku
bmFtZSA9ICJvdmVyZmxvd19kZW1vIiwKCS5mb3BzID0gJm92ZXJmbG93X2RlbW9fZm9wcywKfTsK
CnN0YXRpYyBpbnQgX19pbml0IG92ZXJmbG93X2RlbW9faW5pdCh2b2lkKQp7CglpbnQgcmV0OwoK
CXJldCA9IG1pc2NfcmVnaXN0ZXIoJm92ZXJmbG93X2RlbW9fbWlzY2Rldik7CglpZiAocmV0KQoJ
CXJldHVybiByZXQ7CgoJcHJfd2FybigibG9hZGVkOiB3cml0aW5nID4gJWQgYnl0ZXMgd2lsbCBj
b3JydXB0IHRoZSBzdGFjayAoY291bnQtYmFzZWQgT09CKVxuIiwKCQlERU1PX1NUQUNLX0JVRl9T
SVpFKTsKCXJldHVybiAwOwp9CgpzdGF0aWMgdm9pZCBfX2V4aXQgb3ZlcmZsb3dfZGVtb19leGl0
KHZvaWQpCnsKCW1pc2NfZGVyZWdpc3Rlcigmb3ZlcmZsb3dfZGVtb19taXNjZGV2KTsKCXByX2lu
Zm8oInVubG9hZGVkXG4iKTsKfQoKbW9kdWxlX2luaXQob3ZlcmZsb3dfZGVtb19pbml0KTsKbW9k
dWxlX2V4aXQob3ZlcmZsb3dfZGVtb19leGl0KTsKCk1PRFVMRV9ERVNDUklQVElPTigiSW50ZW50
aW9uYWwgc3RhY2sgb3ZlcmZsb3cgZGVtbyBtb2R1bGUiKTsKTU9EVUxFX0FVVEhPUigiWW91ciBO
YW1lIDxkZXZudWxsQGV4YW1wbGUuY29tPiIpOwpNT0RVTEVfTElDRU5TRSgiR1BMIik7Cg==
--000000000000f42c790646203724--

