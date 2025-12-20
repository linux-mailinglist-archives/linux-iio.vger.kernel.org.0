Return-Path: <linux-iio+bounces-27251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CDCD2792
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE3D3012CD0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4E288537;
	Sat, 20 Dec 2025 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJoBVvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE923507B
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206111; cv=none; b=iaFNr8jPpUGvIxwB8jVrSpZUtuxNDjpZYaNII98D6buHW4Xf4+M7TJKf/JwB2VwBilSarSz1mOHxRrPIYLr540j6zKfvJ0RrrLaa/oHmA1ZadEXWzBrm2Wt0/gMxRNKSxRAVR1PyEvMWbUNP7h4HNdHmpBQoDOWjcLPp9YS5eIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206111; c=relaxed/simple;
	bh=+L23A1py+fllNiKs7ldFSclxFjvRTzXLLF6jgHq1Bzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwcZOC2ZkDXbKzuE7yHf8jZMp8Bz+J01+D3BAyKJqrxZUaKxuEudog1GXuNO0TFAxjw/ERTLskaECxp3zwxTYI8M4UMRtuHqXd3mwwjTpT4fKrWY+DLMDNpAN6JJJ0hoaiL1mOZcndqaasF9xMTDIUYdqCSktIrGCCVQQ3hZ29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJoBVvZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso26451815ad.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766206110; x=1766810910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LN3CyXMZdKGItabzCPVp1yMPiGAjLeQulsNPQaqCSA=;
        b=VOJoBVvZ2h6EKd9EhoGKHNRpSVEfCcdq/yTsIXvPi5MsfBJk58yyGQOy+JsIj/Omgh
         C0geCicrOBtteKvoYe4XO+pdb5dGUfo1WX0dUkxg1N8/S5uwO/eGBoVqOnd2Xd8vhSn+
         oz69izHFo5o/RIMELwwbst2/T3wRwxRtLPC0ad8Peiay9Ntwq/fd9DzdB+CpEEDMrR7T
         SYZbew8z9TaPMZJXFIFHSQi0ogaJM2HmfgJdlg3RL5yrrQ6guNcTzqDlZII64OgmlPAj
         e6rbWtSKHBiRBavAzQ3auMXD9rZLYl6diMuO8CBpUuJOPEREH3S4L53XAq4/YZ5xllAD
         ALcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766206110; x=1766810910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LN3CyXMZdKGItabzCPVp1yMPiGAjLeQulsNPQaqCSA=;
        b=JK0MagiH0Ul/LhjIo+glRQcVMJLjrkQKfikF3vcGgs5ExxS2vf+80noaoFFQGKOWA/
         ZgG8VsA2u2v3aavgf+A+cwROaJJC7rAttZQDgCDwau3VyLlaqGIMWdp0oFyzTC11hevm
         +EzI1FltUWtPRiN9ERb2iFRX329cJ9BQ1l2rG/+t/RSfsK5JSh+FXB37Ml99750i76Ns
         1SUYrYMH27+rSHU782oNv/hUOeuXVcXI/7woUss/ipsc0Tg+Vj42DIovg/yPxvpRCgNu
         fCWuHLsBHf4Z8HjltczNY2N8/EFu5m/B/QtOCOuFOaaJ+YEV7pTawUZmemxfIAnSMD0s
         vFUw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmSla/Y2tpRx7Wd6BR1XUTTgzqYQD465RUEoinfNLo0dhWIYTPyF9Q52ctiLud/oRpTQ3whngxA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWhdHYTIyuXLVTLjyVBNFHAG8iAmfm1IwJ7Q2fRXtSge6oTlX
	MDciJ6BkoO7L4IartGiv71HKzk3E3qsFp9fvYu5v56vkemPoJfNw5/4y
X-Gm-Gg: AY/fxX4//PWAodeyMijHn1EnimnCWo7igvtzWwuoh18R8xt3C+J1OgTz+OqG7ULTVmo
	SI2wFt542NjHiffhqEz/tyEqkcehGrZbziusOTomta7sfCILa21tzwFdIclLkil3lAhnySKEm3q
	BkOL8fCLpvG0+cw4ejKceTr6fgc8YgrN0DX9WsqgILxzcJBFo8mYIxUc5K4PgXwOhWi8miRB0TO
	HXpHx6YlzEtsAJRDpRXDAfp9+Dz8tkky2g7nLG4dMjValiPEhxRJIlT2KObA/iwjGVdarnHq7FQ
	gz6N9qTMIaHHUOaO1NCnVy4QhUFQHz/Mr+ZFCd0QH8gM+NmBURuOYjByRfZb6173f+odaqucauO
	nnNRU2OUdSN+6v2U8hipRjC+fUJajeYMX9drkxg7cQdYf+Ous7wkPb53sAmHL86fzzVyEztHZre
	MJdb9WyqKV0Gu1pTEgPkE=
X-Google-Smtp-Source: AGHT+IE5/eUpFyHxwEZDOHdHSOrWWsWpQ0wvTezbWV37iXwbvizDvMQIlDIFcT3z7VGWtWvOZhe+kQ==
X-Received: by 2002:a05:7022:989:b0:119:e56b:98c1 with SMTP id a92af1059eb24-1217230320emr5838606c88.40.1766206109875;
        Fri, 19 Dec 2025 20:48:29 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm15804734c88.11.2025.12.19.20.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:48:29 -0800 (PST)
Date: Sat, 20 Dec 2025 01:50:10 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/14] iio: pressure: mprls0025pa: stricter checks for
 the status byte
Message-ID: <aUYrAqp21hQr6_yI@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-8-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-8-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Make sure a valid conversion comes with a status byte that only has
> the MPR_ST_POWER bit set.
> Return -EBUSY if also MPR_ST_BUSY is set or -EIO otherwise.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

