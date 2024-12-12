Return-Path: <linux-iio+bounces-13384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC49EE335
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64332161DAC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177820E6EB;
	Thu, 12 Dec 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtDV68h+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA341D89ED;
	Thu, 12 Dec 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996314; cv=none; b=fL0mtk9zemHq4ZgDcLRIjcqp2dISHPxT+f5Jj2lfVRxbnPlKRkKYvQijhVUUSqCvDqReWk6DOV7rVhDeukdaAACc5sYyoXNUbgudI0ZnnJhSUN6kVx3jvpDX2Ktsxubpd3zxOG+FeasyMoWJs8NlUOOPo6hgqQ1Z7xgXIaTKDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996314; c=relaxed/simple;
	bh=5WzwsnoUxUQHguvsxHcVHt+Ku+ywfed8+lG4GzBCEns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILvWAxwWJtPz17WfvHd6nvlcTfoJ1frDm4F0YajC5DRcUlQ06z1FV2bppFNcnseIrUt49OZs0rU2EE+Iki4SAFC2uCl9WBPA9cGUvT6fD3cLQRvuc/eMGOaf+vm4f7S7pTsB4u/d71spdu+B6IPMO2KprnWUcgDTACVMMnZfq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtDV68h+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfdcda2bdbcso3959276.1;
        Thu, 12 Dec 2024 01:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733996311; x=1734601111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imh5l4sq/5PdrCJNze3atmK0ubuXKkxNwBm8kxrrWCo=;
        b=XtDV68h+1VU+S6N6REmJA5Qw3XjJDj8MvDlO5vxvGVBbQ2nfKTHvhmAHWtzwEbZg+a
         s7VVxm5NLqKHDbuIR9YVsJ+Rk6QJ9GMoVYqP2pz4VkONTYcCiwwQG5TsP2KPak7ya0ah
         yd/VeFAf3OhcMEOQPVnfbY8h3LoORQ+36Gxi+lSfJgcQNGXOy9+OtsaJocJYzozfHRhK
         yKk3zcXyxAZrpziJvG/DPsxjs45gikLBwNQphEfyGv+rQziI1M9CXKQjV2tUwcb6ezG2
         Cc5wkI7acWE5Xp51qDj4DE+ixv7QkCf3HzalIx7uN9uDVN6F2JMtRu51la15qBBvQtK7
         ZciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996311; x=1734601111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imh5l4sq/5PdrCJNze3atmK0ubuXKkxNwBm8kxrrWCo=;
        b=GOmwipBzTJTHT+LSiOwrGV+beJ5bG2ZSmUU5UvNUZi6S99CvDCEMQ7ZwhS+TJ1WsU0
         sU40AWb5sGUUL2nvUS1Z/cNC7kyEE+MHNgBJ6Sp+xRZEQY3sL/M61h94SZtU8s3kvtrQ
         jZ4ONGrnZcCfIm3P6bwX1ccDDKV3eKDwWT/LmFuIv/cyW6QwLI9Frimyok3K8V4pJi8X
         sQyVuhsnEBVVcGDu1tbcrlesDdBiDEqbD/ODv7KSpc55uFTb9eqxGW++IESd8fj9FB68
         96tjYyuTJemQVgR0rH0xKn396rxEqkiyAdjqeWRe7n/OYde4Jqj6+1yuxYO91Z+VOoRM
         Xm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUwUWRNBp43Z+Uvyy+ZSshQC65np9At3m2TazIFWhM0EjdYGIJWVIiDlyquj/AzYFAlpCw6JTT5jQqZ@vger.kernel.org, AJvYcCVdYuZjNwymacdV+F9F195VS9hTzkjn88cG5BEket10KTvxiTTPPWJjP6fazr4rZFMegEVp/8YcPMnFLHTQ@vger.kernel.org, AJvYcCXZ1BqQn1opLBphjNo4Wx2z2oqp2Mhv5U5VoRUsviQds+z4NyIs5JKNvGGg8QYgKIHG285vrlbm7Gf/@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWhioIUJqMSn01AZNgFH9Q+Co6Wo4v02jqgemn9nOoYbSq6SS
	RkcYbmiLj89Vtk3FVKgIhSJGQFWQ6/9W3mXxq8sE5pJ3tGZ1qW90S3c63W6pfJm72jTMb+eLbf6
	xdc4Kjj2JPVkoePonwIN5P7VycDQ=
X-Gm-Gg: ASbGncsOthjVgSdtyUHRn8nv3tJV+s7Fqo1Q90T/JnVjYVvLPTwYtDvUVrjrFzXX2Na
	9LchOgIV9UMSfXlYpCXfFnVxKT7chZmoEQYdlmg==
X-Google-Smtp-Source: AGHT+IF6xtcthws4pIZbAopO0fSCLbCgW8wuCaxQhztzhenxBsbcxbaui/bHlXs/m+TPfFsq9NiiPv6wTUlLVLj74UM=
X-Received: by 2002:a05:6902:2741:b0:e39:9ae9:b7c8 with SMTP id
 3f1490d57ef6-e3da1ef2ed2mr1000317276.7.1733996311450; Thu, 12 Dec 2024
 01:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211230648.205806-1-l.rubusch@gmail.com> <20241211230648.205806-3-l.rubusch@gmail.com>
 <ldsvh5heh6gkdljxvgovwl6ni55cudvqw2mihbrliw7dqanrnk@lwlg6irtvg4x>
In-Reply-To: <ldsvh5heh6gkdljxvgovwl6ni55cudvqw2mihbrliw7dqanrnk@lwlg6irtvg4x>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 12 Dec 2024 10:37:55 +0100
Message-ID: <CAFXKEHZr2MT6Ard2pTpQtU9BVrr8FHes0wFO0PU=rM7iFX6H8A@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iio: accel: adxl345: complete the list of defines
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi  Krzysztof,
Thank you so much for reviewing.

On Thu, Dec 12, 2024 at 9:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Dec 11, 2024 at 11:06:43PM +0000, Lothar Rubusch wrote:
> > Extend the list of constants. Keep them the header file for readability=
.
> > The defines allow the implementation of events like watermark, single
> > tap, double tap, freefall, etc.
>
> We don't store constants just to store constants, so this commit does
> not have reason to be separate. We store constants/defines only to
> implement the driver. Merge these with the users... unless you want to
> say there are no users of this at all, but then make it clear: move the
> patch to the end.
>

I see your point.

The defines are needed for the current introduction of the FIFO usage,
connected with the watermark feature. Some of it is related to
upcoming features, such as mentioned in the comment (tap events,
freefall, powersafe, selftest, etc).

This patch series now on FIFO/watermark are just the first step to get
a solid reviewed common base. Further features are upcoming. I did not
split up the constants. All the specified registers will be needed to
allow for their configuration and setup. I understand it's no organig
growth by immediate need, as I understand, but giving IMHO a bit
flexibility then in implementing what is the next feature, since all
registers are already defined.

Pls, let me know, if you prefer me to only introduce immediately
needed constants for a current specific feature?
Best,
L

> Best regards,
> Krzysztof
>

