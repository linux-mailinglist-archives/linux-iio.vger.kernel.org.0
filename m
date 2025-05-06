Return-Path: <linux-iio+bounces-19193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CEAABE3E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CD93B7CF1
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1326771B;
	Tue,  6 May 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRDdcouL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2619F115;
	Tue,  6 May 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522234; cv=none; b=PBl8BQcMHdgURS1HHdGzTgVfBoOFhaYCUbsONbKoHRPlCkwUF1I11ihGh3EP2DyybSECx2VW/3xdK30XthFvaLuSyWDRQd+pkqzBdJGjesQIqeXyL9KgD3MBvQ8CmN4gC0vcYfjj0PoAckexzViq9D12H4fP7BgYbhUNQg6v2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522234; c=relaxed/simple;
	bh=gyIx0Ki5AOaReJxfeZj63dyjx9FKVMsihfA3i8+mBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/7XB7HF+/syMYrbXtMSyC9tNpx6XDWR9KwtnnU0zbCv2YWTWqTKf/un2c6tWniBM1KZ77GK+R3Rv0wDG+R6tYDV3JTV676Rs0JOpCI/A8Py1sevJxwoc2m3UcdIrLJeX7e9TiL6Ec1yncqLdNnt9gnZnCLL+xCSrdoaue5698A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRDdcouL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so4214937f8f.0;
        Tue, 06 May 2025 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746522231; x=1747127031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gyIx0Ki5AOaReJxfeZj63dyjx9FKVMsihfA3i8+mBGg=;
        b=RRDdcouLItgszsRPvJD/IrtKTbR8ipn3WlJETa4xoP0mCoo+eZDgIYTe21b3d90Lwz
         7PgcJoz1w9qhX64X4sBroY3bdPCAT94SKN6dbjPY7ogtREqUfUJokmOaX2orNeg+Ui+L
         o/qnOLRn9UorOLmhvJox8lD1SVRnvwGtFeiMayQTRVvwznyH16FlN8chIc+aYp297vRU
         KR3v+tFMglkMW5xns9kh4AEhtwfiiegbAze/xqCx5G0/AHSLGnMaXSB9scm2CtCeRJPO
         J0sRomX8540b+O9vVv0iLmXWsF/kfnQ5lmst/d8PjdJ13kZENOGi7JNngR45yW7mqWDg
         svBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746522231; x=1747127031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyIx0Ki5AOaReJxfeZj63dyjx9FKVMsihfA3i8+mBGg=;
        b=Zss3A832HR5XBdyXwM7IDqlB9gXkUrDaa4g7B2UaUWIEglrVykiCXP7Y8bL1VXsdy/
         KEJdK1xqebS2uLwAi5xMrvGvmMtLUr6RSlZ8yIOYC/ZMP9PPT3bIxttQ3eOZ+J9J+82C
         NzL498GAiftR1sFrq333KYAGjziT5vXX6R6q0jdeOBg0EUN/eMLZ6ZKvVRec+w1gnST8
         aoNP95pyKic0Kgn/VzJfd6ti+SFJ8nysKXynsoFdRgFTi0G1QlFZYKmrHY9/Xypd7AdZ
         wEvVkkUsoVxF73ahPGJfq7ZqntUukdpgFeus2CDuDoZfJIcsRlbsBwkgs3+mz0Y8pR2/
         qFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUfj9MNAA+gIrJCLKXy9m6KJNKZJ14IjvBzo2tOS7ew0SP27mFjH8QLQriOK9Iesppy3r9c2vgyqOAf@vger.kernel.org, AJvYcCVFvTlEAxBPzghqjVfJ6nl7W6q7wKORM980aFPpvb6lk03r0kn2oil0NUNdyRdtk0p/WMR9jKLt5ZQl@vger.kernel.org, AJvYcCWu57m8T0tTlyOOicUvJIyHLAAOrwU7zHWDPJEv7RJ7Hyk0Pulqod4FJtgRBLKPVKzmrzOUOU1HC5IGwJ2i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eR2q12417gjznhBTmctRMXNQLgnGKZ4lIwcH2lv71TUyzmM8
	SX5F8ysxPZp3tKkf24AVQafjrVAxLlea5WtZ+1po/eOgzQ/uhALw
X-Gm-Gg: ASbGncuAkagXx8brAJpKrJ1kPrk6xsBoZFm51sdx9Kq5zvBHKVlUPQCU6hI0sxdM0k6
	G2SteTENzLvcsnyR73xxrBUg1DBoMEtFBhSzIoDq27dijWCCdqEE5/DnvVjKf42O5vxHEbg86WK
	lQgJhD9kYllKFyzx6KnwnisPznX9+EEDZgd1G0eCA55fuDmm4cUOWJwR/ZflaXMVxJW7APfecEG
	u2pHBmUFFVMiB+2/hzc6dfCzAWuwXO2QX/QMy15Dd7ORRXM3nMckqfcsP234JdPpFGdhRSVUMKj
	+Kb3g2SqVyavZNrSK+CA/YiwoNrDJMN0xFjHl4sOJS4PfYdhIhMfdAnY/z6fF08kK3AMGReqgKQ
	=
X-Google-Smtp-Source: AGHT+IHRYQv7gbtTFV1OT21EShfpi94fTR1K/sawhJ6BR+I4eHDDjPZQutWAPs2LuuqvlF8J7eUroQ==
X-Received: by 2002:a05:6000:2489:b0:3a0:9f24:774d with SMTP id ffacd0b85a97d-3a09fdbc96emr7653085f8f.45.1746522230986;
        Tue, 06 May 2025 02:03:50 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3441sm12755409f8f.26.2025.05.06.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:03:50 -0700 (PDT)
Date: Tue, 6 May 2025 11:03:48 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for the DFRobot SEN0322 oxygen sensor
Message-ID: <3bpvrmrrlv75snba3o4nvnb33b2ibxskakkip2ukpxvfgezwj6@sqnmmtgi3rcl>
References: <20250506-iio-chemical-sen0322-v3-0-d6aa4acd00e0@gmail.com>
 <4ef1f428-d580-4263-9190-d187d1fd0e53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ef1f428-d580-4263-9190-d187d1fd0e53@kernel.org>

Hi!

> What exactly changed? I do not see any changes in the binding but you
> decided to drop my review tag.

Sorry, my bad. I've fixed it in v4.

Regards,
János


