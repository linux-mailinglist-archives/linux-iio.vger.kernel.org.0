Return-Path: <linux-iio+bounces-16445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB486A53EED
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104A93A8725
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890136D;
	Thu,  6 Mar 2025 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjB/8pEH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3342A2D;
	Thu,  6 Mar 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219923; cv=none; b=RDnACRfFjVbcqMHTVMPXZf/oFSUXPr+6uJZnZl3h57T5qCcKUzhRwwcMgx7KGiGDd+v6E2GKkZoGtF9iDvlwcWms9T+iZKcHz6wzHWI6Tm4P2NDrXKDjzRc3ZZ5dgu5tcaitAB1J7nX5U8qdVd1SU5r1BDt4QIrj9CEtxbsJP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219923; c=relaxed/simple;
	bh=QY/dbxRn2hSPG9sYCiIb3RtHikmICWWUJa/v3LRP3ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ7eLbtAoGt6Ro0Q/2A8y47TV2Ynai7XUCIewc+rZf7llLf1QdDWaaFknRl+CnmglB3j2g6mW60/nSTmP4C+z6fqKjP76/+KBTU0GsPCfkuNS4KSO6LyOUIn6TWXTgQ8xk7EcnbmobiDYXbyinBhvOqIYjjIZAiqhAN6xzxGBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjB/8pEH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239aa5da08so464775ad.3;
        Wed, 05 Mar 2025 16:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219921; x=1741824721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZCYeLObjn8U5GWeXbTtQ5qHg8nodz5oZEbI2evLUOg=;
        b=PjB/8pEHwzHvRaB7HzIamIbfu/8WTkSp2Nt4wZU+fNdfAog3SWIpaRvOP8T/9vEbmi
         UXGrnLdyYEPEPryu0iYpwb5m7i5zDPxegPix0p/7Yoar69hMCceEHOvr7bT+q162y93V
         MpuyFuHzjZPq/AreUssPXKIodaebrcxIS0SuqviZu6ZrYsZsjQwvnqUDlmeC2EwkCGG/
         m7IJnipJFYqRgNA34mAjKOZV8+oh865WFzq9lm4Zcc/H4f75ooTXQSDc85Cv0PzV6NMB
         D6xZc5CuFqLA5dE5o0woWX55o48YMTfnAZrVw0nP9uo0OdofIr55p2hcxqCAIzvccGtf
         EEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219921; x=1741824721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZCYeLObjn8U5GWeXbTtQ5qHg8nodz5oZEbI2evLUOg=;
        b=CtKzW7l57vPTRVChumqsOAlknOFQNjPAWyi7wWYV4FnOEW9WDk5DQ1f0s36i/a30YS
         4wBDgA5kjh1SfoyLTX7n+rlJfltJgZaJjllkfuTpNmOR47WfkvQ1SmyEphxc6DiWiALI
         eIvEU10gNMcyDRhs1PcWcvc6s2cU/nfHyReb/31onnm7WeJf+TMR4PVCEwMT+E+Fti2E
         I01SbW+EPLhM8VT0Lm8zXjd2rHssSzfUbB2Tn/AUukVUuVXnJOW/zpkaFxRRUHX7CKeQ
         Uak0567f6tcuWsn6PZRRBLZTnAGN5ayBTI9+IDl9Vq83Y/oHbF7Hnxvcr1BgFbj8Dnw5
         ID9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDKG+JvmvLmr8tsCW7b4H83sfw6/8lQHE0fLahbmvHO8Y6tadcXaFzck5fdjZckSChADPEYBqUiJE/uTjq@vger.kernel.org, AJvYcCXDcr/UZ5l//pGqA9jFm/f1LvxlfBnXnSnohZzATsMN/fReGkAQny5z325kjDcVto73MxXnp3kPebM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvVAWoCP3y8HIH3T/M0+zA3vcwh0GQ3cibaSa8GNF9gji93NJ
	a8jBA95BDQoz8g1c/O75kmKM2MwTEjdYFtcqGe4bsTSjDLOZ9Qm2
X-Gm-Gg: ASbGncvYXkD9J3vbGStJUz4gVRNEx665FQDPCrsWR6qAEZkO/DSW18BGno0PSQOT+nE
	9um9cPSxa1owSgJee+DE24+JGfFLQjGb1Y5P6Aoeoay7LgMTexUno04JcFbfA+TFsqu16NrxF9Z
	ERJkU8pIxlXvu3IoFJeBwt1wtLKh+ZpaqQVhmT47iDqNnwpZqiYUtecdmEGq55Nq/EeP84NazkL
	mK7yARQHIsYkmtKD+MVG/uUrKZ0SdacLfIz0PkKryrOTOn2EzoSx7twk3JgC4ID3tsII+BH2jx+
	1W6r31eyOlvMzisiL0UvkOUo0BLRm20nw96dm37V614VLWg=
X-Google-Smtp-Source: AGHT+IG4syzW4hfKzfRcA9XqhvNMuuxQLjzpBCzPV0TJVG9JpYb89BuAofOHLw5MUEjgzgF8AcR+rQ==
X-Received: by 2002:a05:6a21:7308:b0:1f3:45cc:c6fb with SMTP id adf61e73a8af0-1f349496a41mr9296459637.19.1741219921109;
        Wed, 05 Mar 2025 16:12:01 -0800 (PST)
Received: from archlinux ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281075eb9sm45371a12.9.2025.03.05.16.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:12:00 -0800 (PST)
Date: Wed, 5 Mar 2025 21:11:54 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix initial sampling frequency
 configuration
Message-ID: <5se4isw4f6xpbub62tna53ah2qjcf3mwks23ifc2yn4u462lpn@u53frmcgjth2>
References: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
 <20250305144928.1b9b483a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305144928.1b9b483a@jic23-huawei>

On Wed, Mar 05, 2025 at 02:49:28PM +0000, Jonathan Cameron wrote:
> On Tue, 04 Mar 2025 15:01:02 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
> 
> > In the bmi270_configure_imu() function, the accelerometer and gyroscope
> > configuration registers are incorrectly written with the mask
> > BMI270_PWR_CONF_ADV_PWR_SAVE_MSK, which is unrelated to these registers.
> > 
> > As a result, the accelerometer's sampling frequency is set to 200 Hz
> > instead of the intended 100 Hz.
> > 
> > Remove the mask to ensure the correct bits are set in the configuration
> > registers.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> 
> Hi Gustavo,
> 
> Please reply to this thread with a suitable fixes tag.
> 
> Thanks,
> 
> Jonathan
> 

Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")

