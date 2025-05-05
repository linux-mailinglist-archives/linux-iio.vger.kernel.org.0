Return-Path: <linux-iio+bounces-19076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B686AAA8C39
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912661892B01
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 06:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347B1B6D06;
	Mon,  5 May 2025 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Qluh3t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002FD1459F7;
	Mon,  5 May 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426145; cv=none; b=lsG9pXCKdGv6nedCiDGcM0FNQyyCtY2Ykil7M0KINiFTxWjAURofJt9zXsMfXjE8N0j4dCvQsii8No+0G4ATu+lcLduw6wfQX5pkDPLM9hz3/FXSK+Pj0+qjtgkfdAlyz3nz11JLanStwWIhKBrSp94/P67QPDGdaHncEqf0B0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426145; c=relaxed/simple;
	bh=Duo5WKqyQks5iE5n04QHhkTiv6EU6Slj9UKbtgro9+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxyoaBsOZ0uPFEK8qK5elcy5RKMJxJyfpLHWfkoMuSrxooVCGE5WtnAAHwWw3r6KpxlTZ8hoBRGlEWio/NDAfsbdb91k6/AYM8m6LEcerJoRqxDwhB9t9aWrNzyleXzjuI9KmPCfT90V5HPTVrK9UaFj6AxGGIfgIHvvaeZV6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+Qluh3t; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so2992406f8f.0;
        Sun, 04 May 2025 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746426142; x=1747030942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Duo5WKqyQks5iE5n04QHhkTiv6EU6Slj9UKbtgro9+A=;
        b=B+Qluh3tTJJ+sB63bpof+UPfirutUQ4usDaoOQhE3g8oSbGCA3rPJbHRSozZx00b3J
         4N4rOq850n59A4ljFQrYOfZG9EJX99MvGgnMv0wdilq4wHroBf8GHxhh79vBMmQif1+F
         LEHN0qILqpwEXrleK75AdxdjtC6gCXHaEqDweJFTGvTIxtgEyxStLhPzU8PeCJzTbDUn
         UyuC10WwWgghwSPZWbSNGgd+VfdTdM/pj0Ziqdt/MEPvxkdZQVbmvm33Zmwly9A5busu
         CbZGPaUrFszQQif6zDnGar+6ast1LpDaTiCn5fYNUQyhK1SkPgde4QTaFoUrELMNeVxu
         7gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746426142; x=1747030942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Duo5WKqyQks5iE5n04QHhkTiv6EU6Slj9UKbtgro9+A=;
        b=L+638DGrU9yzJtnU7dPuGQaWFu6C5xNKdWzO1tD14LS4HtKJq4gRnXvmEngYuDrp6V
         nIucDgIcfCrIOAH2hmvb/TTs/JpPb4KQHaQk+fBzGlwXDZbFd2XDEGg1fXKnYCehHomp
         uMH/J5kDET2lVTP7pQaMaadwef2K+MHpgJUhViEh5AEqYcIZOQRcMp9cnrkeDDSVXuAI
         jYqyN7nXJ/mHunfkO8/5JMmTvJzHE7rUgXcaGSH5MCJzT3hfRlYHGYlfaEy+3GD9voxq
         suHKpapW/pf8GPAhu0UeGze2kyKl5itb3D83TCpqJHfF/va87eYxIcn1uhuwJennaSau
         jW/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfvsn/jkPE1nuEnMxcOVAjOGkrPtxJNuF9N4IGXmXAGAv2jF/IoMCaGYX+B1vIUTMEZZbQW6UkzRh7@vger.kernel.org, AJvYcCVd8dev/gaNoBwBzISWeLAEfCN/turXdgTOWZoWQjFUhaZvHczcabRY9uEVvXS6aJmIXASfXhanu+4Wqg0T@vger.kernel.org, AJvYcCWdpsyW5f+Cb9dwqE/nFD6zoFO6z3ZJsmBQolFjC936aaX5gTS93m+ooR4Y9K+59eGJMa1Nuda/bLy3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmWCZH/x3lfUyeZtxcD7EqfNVSL/MBmUE0sIEGMSdIOaOWsiS
	9Sb372SSwycdejtMrUCdkvtSWoKEw7tE14yj0AO+H+7UBseBulBZ
X-Gm-Gg: ASbGncub5SBzBtmo05gwnsVxBBeBIlKeANle5DLnLKT6id+WXy7t/WC+NxXhiGEfAuy
	QVW90HD3UXm651TXfC3+fK1YqgxN5sivud6pnZXSdLTV0poAj2WVsgYmDABQFECAskjqGGddx4h
	gYxsN5d2YOWFw8NHbc4bzASuBYvGUdH5swymNfb8EbeT4h3yiF17LMVrLv3aCO7DN2/xrAWWLok
	X7xgpgNmFw1j0mrMWEWrBNWshNl1f+cQbnnV7mfrLzShREWls05qW5LdAddob8SDNszFphPvtmG
	sjitDQRouG1RhjS9VDUJ5DyX+x9MxL805fhJpOpR4hKsK2c4eMHuSl/Xzpxs8I3b4/S/++DzNVw
	=
X-Google-Smtp-Source: AGHT+IFa6PSKJ495c8AhszxaLJ2l4O8rCrcCUKyRo4T5ew1TOyxNOcHky6aWXz5UiUGTc2UnquVKQg==
X-Received: by 2002:a05:6000:4285:b0:391:3aab:a7d0 with SMTP id ffacd0b85a97d-3a09fd73958mr3875093f8f.19.1746426141924;
        Sun, 04 May 2025 23:22:21 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm9455691f8f.92.2025.05.04.23.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 23:22:21 -0700 (PDT)
Date: Mon, 5 May 2025 08:22:25 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: 
	=?utf-8?B?VMOzdGggSsOhbm9z?= via B4 Relay <devnull+gomba007.gmail.com@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <usgphnspj2y56quulrjcxtib4wv3lpnadg4pyozmkxoc3ayhah@bpyzcn5walmm>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
 <20250428-iio-chemical-sen0322-v1-2-9b18363ffe42@gmail.com>
 <20250504194030.4efe60db@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250504194030.4efe60db@jic23-huawei>

Hi Jonathan!

Thank you for the review and the explanation! I've misunderstood the purpose of
_SCALE. I'll rewrite the driver to use only _RAW and _SCALE.

Regards,
János

