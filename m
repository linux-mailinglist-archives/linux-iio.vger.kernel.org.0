Return-Path: <linux-iio+bounces-15446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059FA32664
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BCD3A1F0A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344020E00D;
	Wed, 12 Feb 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYoHh9I8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3120CCF5;
	Wed, 12 Feb 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365100; cv=none; b=At1IHgq7R16M8Jm4y7dHwYS6ZWxWRc3My/jtmhG5N8kDlTmrPR4GQ+n6QkTOnWjat3NtP/6W6WkzVeI8VxtWpIYI5eydGpp1yqnRZhWniBW4IMk1J1Kq/HwJqsbTMsYLX6vULPP0g2pqZpS1Wymgr+rf3AFwTmJL/nSPUU0Mokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365100; c=relaxed/simple;
	bh=+rUyy8CCsAX49LoyMo4QlyZTIfngKhPrGjoTwwC4T/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwiesL5Qg9yxLF/KybMQcb7AMBL76/rOW+jnC2+dwYMrLrSw55v189nkfspgUZYA5JLxc2g19y0b9VihFE/05/75r8H5wJI1o/XHeXMxkZjSr2jm5I5UyikYKxQMDBgzajQGj5R9XUHLHDTtSHksGgM+WWpQtGI8qXMALLi10xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYoHh9I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC30EC4CEDF;
	Wed, 12 Feb 2025 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739365099;
	bh=+rUyy8CCsAX49LoyMo4QlyZTIfngKhPrGjoTwwC4T/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYoHh9I8hOFC/rd6q6DuWBa0ELk6Z7OMZH+d1Po86Hca4RmKPfp6Iy748FXUdyIlI
	 tgH/3yl0mOAPAoIko670EqeX9y9i+3JZ/uI7ZsPHzcVNNFWCQ27UkVj53+bdt/O6h1
	 tp2zNyvG6uiP3W6uc1ax8M6WidyQaPTSueZo4zk6WWNhXIYT0nyl+heT4KgnulLxOT
	 VgWKUUVaGzBd9JgaNBnvjddPhhnrvtOVueKPNh9Ht9jYirxxZuEV9VqTmcHVbKcyW5
	 ewHSt4dDIHHeiLGHQBiKMVEehzQ+s32Auf+U/HtB+/DzK1kpDbUrePlehroB/oTObM
	 X96pQV4d2Rp4A==
Date: Wed, 12 Feb 2025 13:58:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andreas Noever <andreas.noever@gmail.com>, Avadhut
 Naik <avadhut.naik@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Eric Dumazet <edumazet@google.com>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Jamet <michael.jamet@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Paolo Abeni <pabeni@redhat.com>, Sean
 Young <sean@mess.org>, Yanteng Si <si.yanteng@linux.dev>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, James Morse <james.morse@arm.com>,
 "Nysal Jan K.A" <nysal@linux.ibm.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Frederic Barrat
 <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/9] Extend automarkup support for ABI symbols
Message-ID: <20250212135808.58d2f032@foz.lan>
In-Reply-To: <Z6yFG_NntQfkwYli@archie.me>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
	<Z6yFG_NntQfkwYli@archie.me>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 12 Feb 2025 18:25:15 +0700
Bagas Sanjaya <bagasdotme@gmail.com> escreveu:

> On Tue, Feb 11, 2025 at 07:22:54AM +0100, Mauro Carvalho Chehab wrote:
> > Now that ABI creates a python dictionary, use automarkup to create cross
> > references for ABI symbols as well.   
> 
> I get three new warnings:
> 
> WARNING: /sys/devices/system/cpu/cpuX/topology/physical_package_id is defined 2 times: /home/bagas/repo/linux-kernel/Documentation/ABI/stable/sysfs-devices-system-cpu:27; /home/bagas/repo/linux-kernel/Documentation/ABI/testing/sysfs-devices-system-cpu:70
> WARNING: /sys/devices/system/cpu/cpuX/topology/ppin is defined 2 times: /home/bagas/repo/linux-kernel/Documentation/ABI/stable/sysfs-devices-system-cpu:89; /home/bagas/repo/linux-kernel/Documentation/ABI/testing/sysfs-devices-system-cpu:70

Those two are new reports that get_abi.py detects after the recent changes.
In the past, symbol duplication were detected only within the same group
(testing, stable, ...). The new version can detect symbols that are
duplicated on different parts of the ABI. In this specific case, the same
symbols exist on both stable and testing.

There is a fix for them already at:

https://lore.kernel.org/linux-doc/673e9543783349b0fcf625018e38e4e93fe98f52.1738020236.git.mchehab+huawei@kernel.org/

> WARNING: Documentation/ABI/testing/sysfs-class-cxl not found

I need to double-check verify this one, as it didn't appear on
my tests. Are you getting it against docs-next or linux-next?

Thanks,
Mauro

