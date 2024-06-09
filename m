Return-Path: <linux-iio+bounces-6111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D715901757
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52101F211A9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7D482D0;
	Sun,  9 Jun 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmZU2N9W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464E63C7;
	Sun,  9 Jun 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717956349; cv=none; b=eTckUQC9NzV5Mulo5J9AFchDXuPAm4LSJS4OAxoKi5LnJuAnaYZ7vkvpD9b7eQgMuDiFI4Qox4CMI2AQYadAByq11dARntLjc1Dm6QRAXxijc9nN4/bs/dMY9nOI/ryP7O5ye8wcwXC3y7F8iN2SUxMSjRolEUcgrM7wHMCt+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717956349; c=relaxed/simple;
	bh=7fdJx1+lP8/j+XLW/PaQm/1rXuLy8qetAlJzAMA6k3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayGosPKLDioHrkMywKg41eQPxMj6viZlbaF8DIDUm6ut1eghIjADP5nhDbpgxcEacOG9MKVjY96nufD5E03yZLiCjmwL9/U5fzVLZzLIhR8kxqE+yjLY8w1Wi7bBY5j+djvNB7pMOKqpUB+cxhuHr8LIdDInCvAHVzvmtd2DrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmZU2N9W; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3521783b3a.0;
        Sun, 09 Jun 2024 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717956347; x=1718561147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IANG2WFqu0P+9CPWFfIfVa8HF99uBjdVoBx9tFnaoiM=;
        b=hmZU2N9Wmjksb51S1IfgIThIZaAzQwsw7aEJxMtFZuBxFiraw+LjPXrMDH30kjqSx1
         0CxazOS/AvL8vS4o3XIu5qrQt2buCmyCDQs4fES5iwAKOPOdnnsG5d9dB1tMJqsHaUJZ
         CaxrTaR8Xwiw5QXi+zdgaln62unCmjC4u0uRNiUnWEkZyzrVMeutdmyfFu4o8jG6UZoT
         dw+iBEmV63jZ0tQ487+sNv6GQKfSbhzLxiNuS1qJ7dcj1d3o5cjHHq4bRuiyCJnXZn0J
         Xj1RXjYU9HKEGYNH9KYF3ZBtYoxkeKJLBw4YSZm5wukr9siT1UBuLII2iS8KffBm0aXh
         SgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717956347; x=1718561147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IANG2WFqu0P+9CPWFfIfVa8HF99uBjdVoBx9tFnaoiM=;
        b=FojfzxYok+nNiKEVmy1kf4y0USnSjH6E/p5l1R9iwP9YO5LTXoHYTNWQDShyL2PTC9
         ojfwP4z7Klw+eLfjTMulI6WsYXO7buYIYR3cvVdY5CWMGRs1RxFs56J5YPj8MQqmPCMo
         wDMdCmt8ob7YhOGA3v/5AliI/4Yw74TSRTraKBuWX4hBKq8DxLyCJ7bAqsz9kezNiXbh
         1tc8lAmy/tcSl46frZbtRHREXICA2iSeiOKt/2Rh3yw9THzSIZGbARALANOd+xZos7BS
         ol1g9KIXJSKm4meDqyLOaZq6xVVNKcVid2igYmOc+dTI0WQItByCeOfQEHT13doVoFX4
         D5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAb85Iedsdd94t0lsLNBNIhDdUH6aN36XvFX4ZRzx5vxtYjVBS83jKSbZUHIBM1oaZ9PlRrsCiyDk42E6kdrqzLF15WvVdinx8EKRglNg1Dfk2//wfDjhJsyRZGEwUjvQH1uAZqOGimWAHeUVCg6NcgcnKEzdhM/rybGZQzRnyK2TlHg==
X-Gm-Message-State: AOJu0Yxl+zIIJfDec5XcKmyjO6k6auOZx3WQtSFp2vPqticXPH/aKRVo
	s6eN5uWpLcsic+IODoQ2Pai6oG0t9xCIbe7O3E6g3vYI5hFxaQg0
X-Google-Smtp-Source: AGHT+IFd9wbAaBYz16lGAusX0aIPhJpbi5xdvpCGI35zgbY09//watj1ORR0uxVygR0fHo4Mzjq5fQ==
X-Received: by 2002:a05:6a20:9185:b0:1b6:d9fa:8be with SMTP id adf61e73a8af0-1b6d9fa0af6mr1834751637.40.1717956347100;
        Sun, 09 Jun 2024 11:05:47 -0700 (PDT)
Received: from archlinux ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70426c9f2bfsm2496536b3a.219.2024.06.09.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:05:46 -0700 (PDT)
Date: Sun, 9 Jun 2024 15:05:38 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lars@metafoo.de, christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add driver for ENS160 sensor
Message-ID: <g3x3hltujhcb5qs7klppikdvy2baej3lff2fucmx7efmvgg7wj@slcuwwb776kt>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
 <20240609103655.29a1b53d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609103655.29a1b53d@jic23-huawei>

On Sun, Jun 09, 2024 at 10:36:55AM GMT, Jonathan Cameron wrote:
> Series applied with minor tweaks as called out for individual patches.
> 
> Applied to the togreg branch of iio.git and pushed out initially as
> testing for 0-day to see if it can find anything we missed.
> 
> Thanks,
> 
> Jonathan
> 

Thank you!

