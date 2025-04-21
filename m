Return-Path: <linux-iio+bounces-18448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E9A951E8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888E23A92CE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76926657C;
	Mon, 21 Apr 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acCxHGF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E4320F;
	Mon, 21 Apr 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243331; cv=none; b=faMkz+Pl/wG7eBEI9Yo96vjkf6FYMXVJqoVnxr5eBVypDSpzB1a3YuTNhc2MyLS3nfd1kpqLJZx4r8m2sNKr0txKSQBGH4LsxYznsVsRjMBoq3EtQWsW5rOcW6gmiPdhYyPCQmGKZdVSZNhL3IsJvgmA0dKt7brSAc8WrlKQ01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243331; c=relaxed/simple;
	bh=7WfjRqak32dmDEcbYuCM3PkVd+8nEMKIrPGztxIZIfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Giw5urlTY1jDLun46LFyvSJCMsD5+FBe7UNad661A6NVUbrC/2KwD/oNR0eO7mXWTr674eegqI1F16RyH3OBm6fEdwE/ikDx2D+nX/bpwyH4BkRqU0/4YuyU7gcP9PRN6g0AB57lrmQ92DhvOs27Nr2mdJtPWNOAIaPXpxgogu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acCxHGF5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33ac23edso38386515ad.0;
        Mon, 21 Apr 2025 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243329; x=1745848129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VILm46anXu51tGkwwdzpRRF6UX5t99Pkc+Jaul39Ijc=;
        b=acCxHGF59aJfe8/xmpAj8zM/E1CzmJSKiVrCLLxTYseRan+T6GKhVzqGrED25eUkPI
         SZOQqZucwSpLWI98miZ1PFq3KHeqO2VLYg8L8i++Pq3iRumDrVuZPmwqKuE9mgcalFjA
         qoqpt+aezRrRG3Irig6jlg8DwIdHp599goRiWE0hhM53kWtIXnNMcHvveIIrZCi8Snee
         dfResiKkTsWoNPjx5uO6zMP8XAVPLxWCoJmTxqmd07EqDeb9u0yTFvDwJkQAdUHHCt07
         cuXlyIQ0f2eMFBIwSA7SEeppYBAd9vSjzPNq6BGSwj7hRdGWNdVEwGb7ww9xLSero7UB
         m+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243329; x=1745848129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VILm46anXu51tGkwwdzpRRF6UX5t99Pkc+Jaul39Ijc=;
        b=AyguLCPQJeQjbKZKiC0nIAgNbA7bU+GZsw9eDl//P80dFoC07zYDbANxCSla5GE82Q
         GwRn148Lq0Zf0k6FS7ALE8wqZAd8TB+CsTrZ6Jf65NShUCDs3jDbrYL5QCZxWWttkxvr
         pXM5f/ehkV4hKpUMQn7+9juHqTwoq63glkMw+Md1VRDk84lnDEbodJMKirYY2jzFQG88
         JrR6p2+unVQ+e+7g4OLR7q5Uuv+sz8QrSqSk+fLNrUO69E/8ldIUsigxTlT+xhm6Wfhx
         jNeaZcjPIiVADLkL4rXAT7LSuU2FN9e58Qo2IX3aMsrxLEHMPJ5jrkFYHQh1gw/mVmjV
         SLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWW8b8ubrbghJ8TIee/TKWbYRDBIKpNtnpTIUhk0HtyL8xBu6ycRIRl/HrfSVRK2SxG5GNkjjOdSI=@vger.kernel.org, AJvYcCVO1e3el+YAaz3DlOlu3Y54CHCBprHGBWetMpoN4FXk4bsnR3OvyYrrOj+PCxuNifIzwZBMMXtL@vger.kernel.org, AJvYcCVcpOe2lDeFSF+5RAb8MeQrlZ2PReZBys2yIiEsKAZH/dPllRPv7zoa0j8wRrs99N0JvJZUO/94axIrlYiG@vger.kernel.org
X-Gm-Message-State: AOJu0YydmeRzafwfCxucNxMy9hCSo1WtX18PLLWum91gZ7gLZaDu3Tli
	TFp9f+SrTo5mEOIw7xg2i11/4u3C3QZInw9Sc5ndpBe6qrYgx4dB
X-Gm-Gg: ASbGnct54lYLFn8HhRG4s6++psM7ZOKHbMFNhJTTKWOUyIwQVFTFZd5xg6rtoUb0GN5
	6gIWYo738Te50msZvKE8hBRg0Fv6GpXqSgOiuhlQSKlWCYqEIu2JaIxqyqKl6mLHZH89/TE4g+8
	GGSdfnZ7SlH1rJOFLa2uL51s65IFJ20bh4n1bIJ4d6Fpw3nJBVlgXjoA/dbtkjOalb95tmWoDyM
	EClOAazJeFEizNfJko90pb6k9sC1wpKtBS/YP39+thiwgjVWzG4N7X9wxau0XuLrlIfAZiilxQE
	mcSm0w5RUHtRLvixX1OfqYO+tnkkoJDyM1QkMh5AMbDJT3M=
X-Google-Smtp-Source: AGHT+IHWwCFSBtPYz/rqMUA+PmYcUjxPaIqEwBB5byOOqR1qNz8CJ2ovyvr/GGFQLmKtlFDzEUz79A==
X-Received: by 2002:a17:903:1d0:b0:220:d257:cdbd with SMTP id d9443c01a7336-22c5363005emr177837095ad.48.1745243329119;
        Mon, 21 Apr 2025 06:48:49 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaab922sm6746978b3a.133.2025.04.21.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:48:48 -0700 (PDT)
Date: Mon, 21 Apr 2025 10:50:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64>
References: <20250421124915.32a18d36@jic23-huawei>
 <20250421131539.912966-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421131539.912966-1-gshahrouzi@gmail.com>

On 04/21, Gabriel Shahrouzi wrote:
> The inclinometer channels were previously defined with 14 realbits.
> However, the ADIS16201 datasheet states the resolution for these output
> channels is 12 bits (Page 14, text description; Page 15, table 7).
> 
> Correct the realbits value to 12 to accurately reflect the hardware.
> 
> Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

