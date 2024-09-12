Return-Path: <linux-iio+bounces-9455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E897660A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100511C2197E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999019DFAC;
	Thu, 12 Sep 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mwfNYX3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356041922D5;
	Thu, 12 Sep 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134631; cv=none; b=nl0K3mL1gZrEcZ/zwhM9EAVMMBfJTalC6tdJNJ/LinqyO2sJY653AaAKAVpILjL6qDTKDuMD/1HXOhVjO5m0u0W5OrJRrMNy3UjRVN+jzUALPOUZgqqzcGJpJ3r9UMBnGKlT1a4Bx28XFwya5/GcpRkyWewLvSpFLje68eTArRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134631; c=relaxed/simple;
	bh=zvPOZDENo7xXnJCwzrirfJ6o9e+VQjNkKoR8Xs4s22E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NVItk0N+0gGhoQ0elFPYhVqXaOI4KUBRSkSQt59ZUA04ZUFNLJP6P+w9i3DiQ3xFbWFVUvK8x/5XfFu61fg/zfrmWlgb0KagEzTqW5iM4Sn/n2CVjK4LFETRnbBL0IK+/6PLIRotmMDLRjPxN7j11gFbpPwnGn6whdmKKnJseJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mwfNYX3e; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6Ovib7cydWeepEU+5tt1A7eGUfsqnSXxIzT+y6rDnaE=;
	b=mwfNYX3eOZ11uC/ZpA9ZyOy8O4sqrRIflY/5m+laiYpYUcUy1fR7fMUgbwdN6F
	VbvAmPdtoy5gZYeLor72G01ZvPrcjCsoRB1AVgdwGX476TzYosixPbI8XM0ZnD6e
	tbAkbwx7VOXC7tWBjqtzlRiv2sC9hj7Qdrfatcp8OziAE=
Received: from localhost (unknown [58.243.42.99])
	by gzsmtp3 (Coremail) with SMTP id sigvCgCH+YlVueJmaxWAAA--.15844S2;
	Thu, 12 Sep 2024 17:50:13 +0800 (CST)
Date: Thu, 12 Sep 2024 17:50:12 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: benato.denis96@gmail.com
Cc: jagathjog1996@gmail.com, jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: There is a potential buffer overflow issue in bmi323
Message-ID: <ZuK5VH179B4j0jjm@thinkpad.>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:sigvCgCH+YlVueJmaxWAAA--.15844S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWxtrWDKFy3Kw18Zw43Jrb_yoWxAFg_Cr
	nav3s7Jw4Fka13Jr1Fkr17Xw4j9FWDKFWxGF1xC3WrAFy2va17Gw4kZFZFg3ykurZ7Cr1U
	CF18AF4xGFyrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUef9N3UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxZYamVOGSaplAAAsi

Hi,

I reviewed the following code in drivers/iio/imu/bmi323/bmi323_core.c:

2245         for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) { <-
2246                 ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i], <-
2247						savestate->reg_settings[i]);
2248                 if (ret) {
2249                         dev_err(data->dev,
2250                                 "Error writing bmi323 external reg 0x%x: %d\n",
2251                                 bmi323_reg_savestate[i], ret);
2252                         return ret;
2253                 }
2254         }

The array size of the "bmi323_ext_reg_savestate" is twelve, and the
array size of "bmi323_reg_savestate" is nine.

Is it possible that "bmi323_reg_savestate" may have buffer overflow
issue?

-- 
Best,
Qianqiang Liu


