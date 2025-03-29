Return-Path: <linux-iio+bounces-17325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F496A756C2
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077DA16F79F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C201C5485;
	Sat, 29 Mar 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn9Lxj5m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38577179A7
	for <linux-iio@vger.kernel.org>; Sat, 29 Mar 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743259185; cv=none; b=ACt+/3WmWaFf2sQq1hRE44+jcadOv1KBxrh7upUPDZzi0PrahtudksDdG5bPbapuwV97zbB5z+zsG6DQFQbSax17xMErwhVsr2bWbfdDQLmp5dKBdm3sIBJXDeLp7/tl9DjtzzyG0MvMzZ5Lf7yNC/kug3KIuKdoNppcpH2oGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743259185; c=relaxed/simple;
	bh=Axar7b3Rz0YLILb5YtfmvtkY2bqJ7T4r/LV3vDrlwek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXL+IK0Qv3AqQdjInFUOHSa0YDLsHBbahZ72Aji8KIGeD0zMEw009RQTF80eEdcuH2s8aCAgXPf4ohKf+0kv0uIAi3Fdiv8XAytIgzN8CG19QXv0jyu4Xg6yE4060yECHG22Tl4tn/3OlUvz0NyLRUMux8Kd2nFgfiqJOlOle28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn9Lxj5m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227914acd20so65372615ad.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Mar 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743259183; x=1743863983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fq7TbKwerZuvwlMmCPYdBIvJ/BBAGbBluFtVE2Q4vIk=;
        b=Sn9Lxj5mS6/AkpBedscnmz53i4P+uSdKk9J9LWzuNh2yz4USrZcTeFeLLLl96SgdX5
         YKLkoyCQnMiu76lVxY4Lzlid4y4BNdp9h1yQrd80TrPLHxAdxT/EXf0DHZR+gcIDR8S2
         /Sf+Rcyyhodnf2u34RTIVBLvCgOET612nKdKFcOSIT4ODRLy2EbuC7wMJL6bUpLyBhW9
         yKsiaC3LybOFuAyhh7daDeewYeGuZ+COWuXm0MTt5Grd7imuY/egvtHzElR5XpyzPeUo
         m43peA35d9MTykDdqxnrcCwkrLBqetcCtnOr50hNSTzIIchlBoDmYHlK/I3I+3T178F6
         5Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743259183; x=1743863983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq7TbKwerZuvwlMmCPYdBIvJ/BBAGbBluFtVE2Q4vIk=;
        b=jRvVtu1P+gppCVfwiYZPh+lbJyfofHtMj5gbmf/KYLtJ+dPMCvFjg4545A+b4Fyoga
         EKW7V0zmH094asnKIXzQ7G1RrXvj/iKLFqbnoKn4jJyHEf7x3bxEQ0fPw8bOL2ZFF2/l
         /Cx+Z7lDI/OC8eUgu8oIjdPRG3Ci0b0cDKLpgHpxAuowQLWOBUXK26qLZOc9UKi6Cei/
         dnFX4Myh0unSi/JhmCQ9qcqAgsEYVKD4QOcHep8i0jjynGVaadWX85Blu/CnYqjWB8El
         O3MIUmXpDFf5KoHi04h1Vfv2MhjjCAvcLosnF8SVBpzsKtgGPSZESAIikQIcqlmcJPFU
         nROA==
X-Gm-Message-State: AOJu0YxsVulBETb5F6YCnfFq3Y1KumeJ94v+JwU44C2EuNf2LSffhzoo
	w725noeRgLlODMl5XdCfYKTneTaGcgjfqcrJZwXEZ8yhxXcFSHs+
X-Gm-Gg: ASbGnctiVTytyOns09IQSoP8F9GYwuC7BBYQ91fIp6xyVVw6qAtf2Vw7uvyxvvx2zDf
	UZgVUuloLRTw1pjY+QIKAbDpMZkWaW91ye/UZBgavomtsmO7hkjICQCzpR77p2nk61dh6zbNb50
	vrn5TluIifF1lBxoYFJTmxz3SeRbuXySycbFIgWS4Bj5kPYbnHPguDG6EYgmLn0LriSl2f5Q9Ok
	PDSZNOwTl0nsFpCjl8XQnPsql5QBblYFuPzX5vHTfZcde0a9NmbUGToCin9JAKcapbbg91wi1n5
	9sRhAtJ2mJgXCwy/uUqkqy8yX+B5rbZBY+hrqOLDjFb+3gsZroQ8MQ==
X-Google-Smtp-Source: AGHT+IESGFMv2aeur4dHLkroxvqN277Ybm8aunJrMfwQi8LPCKFK+OMQiHYP15V3cmBMNbLYFYk7ng==
X-Received: by 2002:a05:6a00:2d9a:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-7397f369831mr5789463b3a.4.1743259183221;
        Sat, 29 Mar 2025 07:39:43 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739710cce59sm3622154b3a.159.2025.03.29.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:39:42 -0700 (PDT)
Date: Sat, 29 Mar 2025 11:40:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: =?iso-8859-1?Q?Andr=E9_Luiz_R=2EC_da_N=F3brega?= <andreluizrodriguescastro@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: GSoC 2025: Analog Devices, Inc.'s ADE9113 proposal -
 Community
Message-ID: <Z-gGbKleF-stHxf6@debian-BULLSEYE-live-builder-AMD64>
References: <CACDprpJx-eVFCX4req7fZLCGQ7=dbTYsji_j7k+WjttUTXb2mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACDprpJx-eVFCX4req7fZLCGQ7=dbTYsji_j7k+WjttUTXb2mA@mail.gmail.com>

Hello André,

On 03/22, André Luiz R.C da Nóbrega wrote:
> Hello everyone,
> 
> I am André Luiz, a third-year student at UFPB (Federal University of
> Paraíba, Brazil). I am pursuing my Bachelor's in Computer Science and
> wish to participate in GSoC 2025 as part of The Linux Foundation under
> the IIO workgroup.

Glad to know about your interest in the IIO driver GSoC project.
If you haven't already, please, have a look at the project page
https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver.

> 
> Following the proposed project from the IIO GSoC page, I would like to
> work for the driver development for ADE9113. I am very interested in
> the device since it's a challenging proposal and it offers a wide
> array of learning opportunities. I have prepared a draft proposal and
> would like to request a early feedback
> 

In addition to general proposal writing tips, I've added a proposal template to
IIO project page. Hope those help students elaborate consistent project proposals. 
I'll review all proposals after they are submitted.

> I'm very thrilled to fight for this unique opportunity to sharpen my
> academic focus and professional future in the IIO workspace.
> 
> I'm not familiarized with IRC and IRC nicknames as of yet, so give me
> your feedback.

Usually, there is no much activity going on in IIO IRC channel so I wouldn't
worry about IRC.

> 
> Best regards,
> André Luiz
> 

Regards and best of luck,
Marcelo

