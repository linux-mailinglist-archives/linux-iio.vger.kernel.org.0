Return-Path: <linux-iio+bounces-9006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB609688FC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9631C22B60
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C4205E34;
	Mon,  2 Sep 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tf7WYQKP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755115E81;
	Mon,  2 Sep 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284160; cv=none; b=ZKugL2Vz4I2NJpiSnOuDYmVEURNc0t49ziS61doQMPxDgj9Ho/aVb7/YA0fpegyAZjyEK9L805BXt6n5um1aGyEZ2x4xqjo/A/laDjiBHLvXylw8a84K6Xzb6nmvmHTkjQhE0ugTQ76g8F9wtT7SgRox1p7jUDppfMWVZdadey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284160; c=relaxed/simple;
	bh=myzTpat61MIsab19VWlZcwXNo9zrXsSd/F+mKI/VJr8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CAAWszbih/howFEajM+nSGT7AWXj+yYy2YAmD+E8twNQAIPgo2PdsHDmGwwUa0qdlFfoOvA7M9bd7kkri4u8EQ7drR7pSL/PblhXZWW+lcM4jVwRJaQmspYTHZncQwfPaQbJ4fqeo7ZepSSIlq1tJ804xZzRO+HylQshXXYz9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tf7WYQKP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725284138; x=1725888938; i=markus.elfring@web.de;
	bh=myzTpat61MIsab19VWlZcwXNo9zrXsSd/F+mKI/VJr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tf7WYQKP5cBFpQiEODZWraejC7TeIW6OSJN5D+FdbD5LlwTyR8I+FLCazYXj+4O/
	 7KdQkQ35IG3u6jKjcRmWJygqH2HMVRkUTZcDt2w/55cAda852zbz+ZJCiqeeamgJ8
	 TZKWdnszQBNoiZ42eVuSqo5H6vw+eRcl2g/Yb0BkFGL5MPTb4zw6NNfVn4/+kctjq
	 DY4AqWWgy56/x6JZjX4WYhMiHWo4xare1ONI4VPopItboLWoSRD8waycyfE/YDadv
	 cC/R4Dquzvca+++r0S2E8fyh/x4AEcpXtx/fl7uRAV0sIyoRKw7i7ofVghWLZ5n90
	 B7AG18u3VYdZqh/tUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc3T-1so5Dr1l6D-000DGt; Mon, 02
 Sep 2024 15:35:38 +0200
Message-ID: <25f3cbe5-1491-4f50-9971-d251c407879f@web.de>
Date: Mon, 2 Sep 2024 15:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Gyeyoung Baek <gye976@gmail.com>,
 Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
References: <20240901151150.77074133@jic23-huawei>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240901151150.77074133@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bLXerX3l5Sa69vDgtB/IqwzOZys6aG3vGqGt/czKkiB+kmGq9dn
 Ec3suAbe/VcVO+RsXa9VuDG9MJpVevrghYQEPhZJ57sgPKUcJTTSMvwEVMVLiWaoQCjCq9u
 hwp1bWzAHvVr097thnaisPu3XcFE4KNUOAHtZoGRTboc4xk3z01TmV8mBfNjmhRLHzqac32
 bX7nxjeoBG+R2lEHMW4nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1U8H7BjXlq4=;NuUnIAGeMCtzNs6sRKU1X9nc7jb
 SgU14kl4gLX/0aVhjvM3K5cWGkGM8R+Tm6ZvyWBDXt4VQxvlGtPkS3c/hcvjDIEdzOT0g/ifJ
 Xeg8jPOhHwiSLXTdmQaetO3YrNeAPU/SqbYm08F5p1Hnpiu0a9Hq/jXcWl3Y+KAOKDyf0R4Qe
 +Ef4vhejU6QHCg45gs/iDJruiKjmIwWs8+o+yXCSWmfgzFM+XSRLYHQiUQ3lm1EGIiFL0Z2Zs
 864HGlQyoDj7Ov9IbmO81mMXsRpAHn4tT94EQ7u8+ttfS/TX8Qi36/S0d1ulQG6Gl3Z4t7WoX
 4UxTi+iD5lVHlXzu3v2nv3R4QWxXvHpLx0zC57/dgL+V1LfBSp8Q4ep0xtPyfRaV4cIahhSzu
 h9JvNMcOHQ+QLSR+vJdVW+ogxGFdKtZGEf4TRw9NAbcFZvBNtd6G84dY0ZGx4BXYYDHYH1Ic/
 r6XlGVHsEmjQg06gUMQ/PZEM59Kl0Ur6hpprRA1kjOTLZsEB5mBmLuqNGrI5vCiDFVr3jYQVA
 sLVl2gzl0L0urV4DnVb9CRaiPbK52BB5Y4sGnHbzj26Gbv7KU0CKBE2aiRuYaplfpqooVvOOl
 EpjgMVbsL0D3NyT6f/fpPa59BFc8UcZL40i3A44COmmdT5mpvO3Zk5zmsKNykAcyQbdvf0U7T
 TVVeUh+qbPZGyRyxnHnrTp2CplpuC8t5OfRQQFuylsD3vZhIJMWcliY+AEYB59q1d7mXWX3Gu
 Yp8f1lmdm/QoaQ5Uj/1Mer3UvS4oZaqX572zujBFoUE9ZBem8A6t0jvYlJVPl0s1XSQrwieWe
 ZAEmwKlD1viIcHDz0PKRJTkA==

> > 'flush_fifo' label performs same task as 'endsession' label
> > immediately after calling 'env_reset_fifo' function.
> > So i remove that duplication.
=E2=80=A6
> Ok. This doesn't greatly affect readability and the code
> ends up a bit shorter.

How can you find such a change description acceptable?


> Applied

Please reconsider this positive feedback once more.

It temporarily looked too promising to apply a goto chain.
But the original control flow needs other development considerations
if you would like to reduce the explicit repetition of common actions.

Regards,
Markus

