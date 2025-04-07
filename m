Return-Path: <linux-iio+bounces-17795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F1A7F06E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C7C188D571
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009401F4199;
	Mon,  7 Apr 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpAqkqeU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95028373
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065987; cv=none; b=FPl7XOTL9o7VkpCGyZTzoF3HAqCwNkfKQmRHRGCtOJf/s5Bx2vXcm+EDFf7q9KumlXjUt6hyLCxBEcos0m4qW4ZmuUf4WNtQpruiQhPydOE1bjZgJXjLQ3P6Z51Ai+F7jcaiGS3YSLshYPAbJn8CawTcta4c3maEMgW53tWsCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065987; c=relaxed/simple;
	bh=S5nbB17hSVRaWJ02ibN9r3OsVqycwOgW/GuENakWUTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb8XrYzkdaN2/pv0KJOE2eR/Dkvq5RhL/zHfzJe4L9wTtbTPnm+9Kvbe7yrwhhekjOtOlTim3DNz/KDtC7uX6SOKE6D+n9c+86Y6DGIn+9/TZtuvJtkny2YNQG6zmHP4/SUQZD9+Ex7T1SAv7oD5Ad0iD1l3+mgtZBcHp1gZKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpAqkqeU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3972913276.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744065985; x=1744670785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5nbB17hSVRaWJ02ibN9r3OsVqycwOgW/GuENakWUTc=;
        b=UpAqkqeU+jr4eaUxxomBa/wXxnHS2ygfFjfDCaPWH/lCCaq5HO6NqThPnGIqYWcjyR
         JvLvT7PvhYI5cAS0USOl+3kdx/7WZz0HwqwVAfFsF7QsbI7ZhzimCq2zOg+ynlk1lbCU
         aXMwscvjmL2rHzpPknAymhlOVMmAzlMgNOF/LTvSTrPxphcJC7Q3qcmQLGrZb+vy4nkR
         HMbGTVOP/XoX5l2ExWuKfIY6xwQYNIyb0sthDDLzeGomqsg+uhgVUwT/M6Di1lhqCnwd
         t16KiadzpN21xwHlkC8PfJePNnNkNC1/gHhER0WmrsNuUqv8x2khWWNCwyuDJNpkAhix
         8B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744065985; x=1744670785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5nbB17hSVRaWJ02ibN9r3OsVqycwOgW/GuENakWUTc=;
        b=YObwoSKKeej67MqccVqNStDVHtYyrLKD6K82MNBuJc1Nh9wPOjHm2qXw/4gi7hvyYE
         TcHAx5ZC0WwIydzQR2OC5kRuasSl+2yeeiMQcNzVdloj0YHjJheBnS5xVQO7EC7C6dSA
         mhdnxCCaNcmQEEnHCLY59jCUyDgAsDVKrwwPK8oAX+FaV97YOasnWQBnBK3Edkf6kxzm
         AslX+/Y4vm/LqOrPIIUVDQ7u8FR5rG9ZEqX9zBWwefwqO3Nog72ZRqyAFzzQe4afE7LE
         ukupnxw3kROMp7NN/lfIQSWhRHcKkW9B6bNwuwBZPzq0maz8KHHBIfBvg4LkqfgadCyb
         vkkA==
X-Forwarded-Encrypted: i=1; AJvYcCVzfZC58YzADMz2l81RILljmMEC0QNyzkPg8ldeZe8I2u+LnmKZSt0Oc1nDL26z+J/irHLYknmohLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPiNoUs+SEHooI7O7+3qYg5yby/OWPCCdQbM/iQw1AIFKweOM
	lxOexjZOVljnB3im3QAyE9iAqnKDpy2+nya/SNlnWQ+RhpuSChNRvuQUc20v/8muIrA6JtoWx9y
	+aKf0IXsSLnOH2me8TOPs63d12UMQtxDCalc=
X-Gm-Gg: ASbGncunX+Sqmb2t+NIdIkZNzTdo8ZEy6V0LTa/Sc8CZkmYOhSCnNOQ3s+MkyZvfC3S
	G5KGvIJTyNTehwygSq13Kdn40i3VHRwaUsmTc/3H+FjbRv6mqU/XFTdTyMmFnV5GrKtJVPaee/i
	imEm5S6qw3/VKHpxibCBA5H/7m5HlvaG+60/oSoDcuFFib+QrDvWgfrCJ3fyU=
X-Google-Smtp-Source: AGHT+IHsnnrjiTD66dV68N5HQY7Kq8cPEnpBwo5RYlW4OCxCqvbQJ0p1f0ISTUEj3Bdy8EERhvRsPnRUiX+ShOSPiKY=
X-Received: by 2002:a25:b1a7:0:b0:e6e:84a:e7e5 with SMTP id
 3f1490d57ef6-e6e1c1a7467mr18057564276.7.1744065985255; Mon, 07 Apr 2025
 15:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei> <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64> <20250305145749.413fe30b@jic23-huawei>
 <CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com> <20250309161143.2b730912@jic23-huawei>
In-Reply-To: <20250309161143.2b730912@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Tue, 8 Apr 2025 04:15:47 +0530
X-Gm-Features: ATxdqUEasjP5DFOtiHrJ-jpf-UJkoi_cAJ74KgzBUv0SLLQGIZhsBaOwXyY_JJc
Message-ID: <CAGd6pzPDL3FG6rRzBrT72eDdtE+ZMNx4A=WUj2xwA2jvYZBHdQ@mail.gmail.com>
Subject: Re: GSoC IIO project: Siddharth Menon
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

subject: adt7316 driver viable as a gsoc project?

While working on the patch for the AD9832, I started looking for an availab=
le
AD9832 board as I didn=E2=80=99t want to make too many changes without a te=
sting unit
on hand.

While I was browsing, I came across the ADT7316, which doesn=E2=80=99t seem=
 to have
existing driver support.

I know this is last minute with proposal submissions closing tomorrow, but
I=E2=80=99m considering working on it anyway and wanted to ask if it=E2=80=
=99d be worth getting
this board.

