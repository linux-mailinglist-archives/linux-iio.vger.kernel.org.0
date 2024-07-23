Return-Path: <linux-iio+bounces-7820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB3939D40
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F321281CF0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D214BF86;
	Tue, 23 Jul 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5al03cT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A88288D1;
	Tue, 23 Jul 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725756; cv=none; b=DQXSRD8cJPUqMNCECIdHvn4LKgSqwwrD6oILzQCZnHJtsY7SnwAhR2iF5PMlqc6z4jcFrWkD705bZnhc/SLvRGVaLqBXELCyvHnocLX7zLRbfqEZhbv3I4NyDAD+lrbueaOD7Pa9BfDDiPW/3R4fPxJ6CV2y8oFyZx+zAtyoaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725756; c=relaxed/simple;
	bh=zxajH175eSZkZBY8hvbs9Q0MP4UlDAvRm8qrsEommjI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fnY6HmUGWJqzAu89o9mVB+MF8aUROlnDlrLpiXMGDfpawQKCdaCHvlefqM8cIgKNXuEBIYZA62JmvWUrl72qDtcfICtXAPylx/n1R+BiqzvRB2zOd6kyFeQiDnuapgFlwm90S6/EVH0Xtk4PP2Fglj+zw9/6u9p0IdFfPfWUYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5al03cT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367940c57ddso2713462f8f.3;
        Tue, 23 Jul 2024 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721725753; x=1722330553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq5uI6yFCXe1RvkWE4wqaWmyGophhncZr7AfcVO6w7c=;
        b=i5al03cT55GY8Jk1IVN51rTdVh+xl3WdS9lcwf4o7m1u+Mk1UUVquaF0+dPr4q4LoV
         Z4RcWkbTdG8QCyrb2BK2Ll3nEFM+otTQhpnPareRIC5K+JWlcWyqfvskGUgvBLOkAWMF
         Kzf0AJWX1wQXWKHyoYo9p5Udex3JZMu+kPvTaFbX3FeD/IqR1jvXtQM1da29NPORRX6p
         mrAMoEFG1ITWkLEySxp0daM700zjahcFOHpswZfeerq3QLosldm/TFCB9mDzccWfiFZy
         /IkjQhItTPDwhUEfosicmpk1bAspm7J+QLAZwIrTdkIrMmLBZxk97dFwUp8MPMEmEtXn
         SHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725753; x=1722330553;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cq5uI6yFCXe1RvkWE4wqaWmyGophhncZr7AfcVO6w7c=;
        b=t9RHTS7fD6qohox63iBmX5tgqz4g/Z6iNHtM7X2dkibpu/cbUhZsgDzOnvmuVZ64oD
         bIZUb/Ngw0Y584hzYEp0AFo4A2adTJLBiegVTEmi13OnL5L9+Z+oAnQUF56Jic0oYiTx
         CL8JUqvKHGyEBG+b459tWeGRSMuCatU57nPA3MOuajDcPyACHS7LWIgk9+8pVrhk0rT8
         BokShp8C2PzB7dzp1O5VLB7EV7Cr1xzfCvL7qbTOJXnUvjO0n2G1HVvW8iHSQ9eJhwXq
         b4aXntlXon7LzgpeThM2gbO96EiccLTMD67hVnm4zrOQdPEF7xfjQ6z3Y4YXxyTwncvP
         gvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU60w3F5Trzx32/+SIe0kn8yGPIROCivTY022SEyxVMRqY1ZINRHyaRiLdU461eKqu373hMykzPciPsgi/xi7xwlt60y5HFiJU4WVNBPgTHjPeUxWS2uo80Ytw5JlkISNpWAW6fmNbL5QRNQ/hMWaqjzgMWeoGHbOFqGN1AFRb/pKKcrw==
X-Gm-Message-State: AOJu0YwTVu00R0+JVnaVqN17OtXfIK+KFAUJ5n9qf/0+sHmpZwQ2jRcY
	CuIx6pr5lNf5gETsSfI057OVkN1dtE3qkTrcguTrN9g3zSWGsZqa
X-Google-Smtp-Source: AGHT+IFlo/rixZejMPA8WXyI01tOP9s64luIcQhd8jz1vK+q1tKwXPSxztIQFD0U1T+9HnfjcOoZKg==
X-Received: by 2002:adf:e6c9:0:b0:369:b7e3:4983 with SMTP id ffacd0b85a97d-369bae01bdemr6535785f8f.1.1721725752529;
        Tue, 23 Jul 2024 02:09:12 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cec6bsm10876331f8f.71.2024.07.23.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:09:12 -0700 (PDT)
Date: Tue, 23 Jul 2024 11:09:11 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <669f733746811_7023703c@njaxe.notmuch>
In-Reply-To: <20240722210716.09ca4223@jic23-huawei>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
 <20240722-iio-pac1921-v3-2-05dc9916cb33@gmail.com>
 <20240722210716.09ca4223@jic23-huawei>
Subject: Re: [PATCH v3 2/3] iio: ABI: generalize shunt_resistor attribute
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Mon, 22 Jul 2024 12:03:19 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > Move ABI documentation for custom shunt resistor attributes into the
> > generic iio documentation file. Exception for pac1934: leave it
> > untouched since it does not comply with common iio ABI generalization.
> > 
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> This stands on it's own even if the driver needs a minor tweak or two yet.
> Hence in the interests of not having to remember I've read it before,
> I've queued this patch up;
> 
> 
> Applied to the testing branch of iio.git. That will be rebased on rc1 once
> available and pushed out as togreg for linux-next to pick it up.
> 
> Thanks,
> 
> Jonathan
> 
Thanks Jonathan, should I remove this commit from next version of this patch
series or should I keep posting it?

Best regards,
Matteo

