Return-Path: <linux-iio+bounces-10195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50E9918E8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9D91F222A6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557415539F;
	Sat,  5 Oct 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzj8Frlt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80344C77;
	Sat,  5 Oct 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149740; cv=none; b=lbaJiLBtvm2/tB9bj5NiimTjZuWiL3Ycdmk0OP6U7niakHM9ctGjdNnj7uUf5t2NhwhC0tnRxsgrAy8NjhczL/if0BAp4b+bndOPwuskMJdL29X3TmIjVP7N2dTvJcSvdphT2APixof2K8ibaJIqWtVaQjUdv1RYclb7YgHPv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149740; c=relaxed/simple;
	bh=LX4OK9Ao6+30UuUeEaSdtHk1qdTEF6u3IOowQ+dQjK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNYEwTu/pmdujibm7lOqF43bdNDXPC5JY7KtkS/GuWxRoUdV13DpFMcT10br6DprgQLtZNK/zgpFS+XgbbL4keM2GtUU/UGQ39xw5RsY8TQ8duyEJkn1XvlwINNO6s6cUi9GbT+TXsmATIiXAEGhQth82eEZ8RvquAapuprYGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzj8Frlt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5399041167cso5037626e87.0;
        Sat, 05 Oct 2024 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728149737; x=1728754537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zaMevDsCDSQy3p0xdoGuwS2vy2OJkKbrzaRiSGEZSnc=;
        b=Uzj8FrltkdCwMIVnMcFnr9bIN759rAM/taocgOY45QrOyoHIeo3quLNXGe+Ouw0TY7
         +q1BnHpwdqS3ZdQ4apzW457CZ3aDQzuh00jZh3RDLTnvED5LAT+/78L7MB+8bhSEDHPn
         wtsQbPHmfv6ByvRmFs9t70oY9it96dk1JkSJ768Kvw6lxLfjv/J4jDiwpzuWZfl5lnhv
         fHxltI2FguK8jaFekNucxjl7HSymAL9FBuobXOvP+GoLP/l0GeQZdw1mau5GuisXySSZ
         EYNzZ4L6JcLvx7h+bprCIL7oUEmpyysHb8kIlNJLjAKN1irMWrm9nN/PyG8NlAMHzreL
         kE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728149737; x=1728754537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaMevDsCDSQy3p0xdoGuwS2vy2OJkKbrzaRiSGEZSnc=;
        b=hoO8JPQlLy+FemhlVWSw4pgwNTXmNMbeZdzQJCpZL3v+NFoitAFkqXs/OT+ZmJnEnw
         fg7d3C6uf8erlrkXoCL4m5qeNOb2Qt0L5aU/Q8q+lo2I8BHe3GgpOvydLkiAsNzkdxmm
         aZB0KF1bFkICwhdLgvKog+et7nwVICeuyI9XLzFZPf+yBTrDvKznfBHkFY1EP2cjF+1e
         /R9Sf90HIEPqsMNQVeaCb+AsALiG56rk5aa9/AgjhXz4TNr8s3FQSUz7RoS0bKcI1ykt
         gjmE7JSJSFYY7iGw/bH0PDIXG+nDY5VYCSTyMeduzofqLPqGX6VJjCDWyVvbek6MIxwR
         MTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Cupt29HQ9OTkqK2Qf9ifg3NodI/d8WZgmeHTrvMqJKT1UMf/RTmJkQVAmg7xJ5dZPJby0hzmnR3LPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9D8sdMD86TP4VeJrliLOKac/WpslY217+9qfneAZSZz3m3PHD
	RO7ThyIEfoVGr98I2cejv90YNAOoTFIDXDpeMAS1pF20uiYDKPpr9hhz6kYyyRv9IwkzY32DS6K
	Blq7A6rNV0n09LIyLR32zqk5wQ5k=
X-Google-Smtp-Source: AGHT+IHonTMEmxAoPIPMkG1DMaD8Zqkme4MoCJJdgz7W2vuerVm+etAiWKpkIbNieVGxxuTMdDjbVI0/z3Rfvfx/Hp0=
X-Received: by 2002:a05:6512:6c5:b0:52c:d628:c77c with SMTP id
 2adb3069b0e04-539ab9cf364mr4400695e87.43.1728149736676; Sat, 05 Oct 2024
 10:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
 <20241004150148.14033-3-abhashkumarjha123@gmail.com> <20241005174755.6864d482@jic23-huawei>
In-Reply-To: <20241005174755.6864d482@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 5 Oct 2024 23:05:25 +0530
Message-ID: <CAG=0RqJntw8njb-tzbDU5oALCNd2EEb=QFP=Uqzcxsehy4mzbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: light: vl6180: Added Interrupt support for
 single shot access
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     if (client->irq) {
> > +             reinit_completion(&data->completion);
>
> That's late so there is a race condition. You might be delayed just before this
> and finish the measurement before the reint_completion() in which case you'll
> clear the complete() that happens in the interrupt handler before
> then waiting on it.
Yes this makes sense.

> This reinit needs to be before whatever can potentially trigger
> that interrupt.
Can you explain this part, because where can i reinit it, The measurement
starts when we write the START_STOP bit to SYSRANGE_START. So should
it be before that.
I'm kind of confused with this.

Thank you,
Abhash

