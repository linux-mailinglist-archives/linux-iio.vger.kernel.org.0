Return-Path: <linux-iio+bounces-23115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A31B302D5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 21:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E7A1BC5CFB
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97D34AAFE;
	Thu, 21 Aug 2025 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjipredU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7601F948;
	Thu, 21 Aug 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804233; cv=none; b=JXEfslm2qIPYVFJZ0mvyjNFWwf+cxLnjPCEHdvMVm7luVgBqggqb6wt5Ss0W/Brs2BgBtfZfRin91o/CKkE3oUdMQivYlJXsa8lp+3obI6I6wPESG5mKE0W8U4C7GkUJ7IeeiNL491PxbhR9xIpF3jjRn+5TNlCovKTKW29UVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804233; c=relaxed/simple;
	bh=ZjZW3xaTk92JHRhfwk9CdBU4Fsf43qj1FDXPfSJqJmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvX8W/YU6dfCiI9+nGSOgbSXnPB2nJdsUipW+v0QbBFHf9WhCmqte8AIrJvjjsrwojImBHS+/z8/pmp6RbS35L579aPth1yyQfd+XdMDZXk7qwOMgbzyGfXTbTK22KEJq1CyUjL2L3sSr0zJG4btsDOY2GadyuJUiOIaVDdlaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjipredU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1216995b3a.2;
        Thu, 21 Aug 2025 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755804231; x=1756409031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwLToObS9wN2E94iBpYxKsBNZP49OCzPMmD+i5CI6oE=;
        b=TjipredUurrGrYcvsbMPzq/XqxpCrYCx4v7AyLUiP2yY9urlsYGy8SWh7ENV3+1UNo
         x9+7mIvgIjwqSQ8KasXZBRWaJoR9f5QJRYh2Bg7yBToZtbG6VS58sMyqb1p0kRwl+9Ue
         mqT1jbEXFr+WhiHYmgaVX/SeGByj4LTNUkbiQBqpDgmndGUN2rmurWG4Z89t7CTY39U3
         OxQtEpdQ0SN1QbmDH7BP3T+48vARRs8+Y8XvCvCXTRazgQ2MBgyuLWLRsNq8CbCl1Wz/
         tjI4T/qBAG6Ai7tgUj/6qhx3v5l9zAmu4EgJtuYBBgqSDJKAt3aYSqcP9lzPixWEP07P
         SCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755804231; x=1756409031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwLToObS9wN2E94iBpYxKsBNZP49OCzPMmD+i5CI6oE=;
        b=Imr+ksZ2/ejmfjNnwVIyGouZA6Iegua0n+quZs169ZHybntUmeXCquvJBL9ThLlhpl
         3Ysn/ULi/rPZXwqh6/QzUEi2448I+dgNjfZml2c/7VIJja4BhZdDQjRANrDbYH6t2srv
         kGIbaQhcumPLC2DQq+lwjFz3XMsgp8qA+gMQrjjZ/DHCwLwoF+6mpLJvM7PdZa+urEGf
         nW1Ez6Emze56PfHP4b0LUDZmH0LdnO20lLkzG1k1Hx3Ur+iogO6dke2Al4fo+JdmrDyx
         IrLTDO+4mv4g+DfrhIfWStZfnhXtZT77l1bV0OqPktcGRZ4d2EFsTX/XbIH+JtiqdLmp
         xbNw==
X-Forwarded-Encrypted: i=1; AJvYcCVd/qJsTNMwuu8LI+xukMwuQZSuTGIT2607LZ1EUzRHYom5FO0VmYRbOfmhJQHoOcGXWdtCO2li84v4@vger.kernel.org, AJvYcCX7voERPqaMGRlODf7XH1drO/shhhCpuj300EWoLkZ8aWuGQAC/VuXAwGBH2afhabxLLFJVmJm4B3ue@vger.kernel.org, AJvYcCXIqHnUjfodv8lEz1os16ZZTZtn91XFxD9RAXpUGOKq0anwNqVybWgEzMgQV1YytAGMTH0vI0qP45tl5Qba@vger.kernel.org
X-Gm-Message-State: AOJu0YyksvHSnF5k4dEsIC8F3ofb7cnX10WCtsFx0PAEx3BoL8pNdEAG
	1uh/y3akhfH7X3bCvoUn2XkMrLa30qYwyNuFKHBxPI2FKmDwCeii+/q7
X-Gm-Gg: ASbGncu0YETLRQZ3vAQyeOsilcKK2pFnNrbO4azOwOrVPfwsIY5/Pr77OvCZ8mYhGhJ
	pwJQBEErj3hHH2YTv6+/qO9KYl9/Btz4KsSmuNCZWoFAcIXFnQRJjwmjQZOqeAU+04UY+LsHGdb
	36w7++mUp1semiP1Herv9S/hgcx3bkZtvrp4zbiW1/B8OG/5Gb0BHDKFKDEtJ2WZPRU9VPfEqka
	bN219xTFyqoZZGbeHFDtcGGIOd74xf8GpJlV0YR7Ktz98vgOPN2t5dPQL/RNFvCcAuCoMn1htFH
	J2K4grikpXlLAMTA4ttY7vi4SlzRRuIrWIPSA8xDSBbo5HaEj+ocmWZYs0PfgU+FUdn7MPFkK8p
	D+jwlrLPYxaRwPLwtqF/IdLW3gCVAYw==
X-Google-Smtp-Source: AGHT+IGLIIWFLR1VKYkqDlFL8XdgVSTqxteEHtPGg75YFIj2fes5gzkZ+w4ysK+R7xQKent42dPWgQ==
X-Received: by 2002:a05:6a20:2446:b0:240:66:bfbf with SMTP id adf61e73a8af0-24340d2c0aemr368744637.32.1755804231225;
        Thu, 21 Aug 2025 12:23:51 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e951da867sm5037870b3a.102.2025.08.21.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 12:23:50 -0700 (PDT)
Date: Thu, 21 Aug 2025 16:24:11 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>
Subject: Re: [PATCH v1 0/2] Add MAX14001/MAX14002 support
Message-ID: <aKdyW1rWlwNFg85k@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
 <20250821-haziness-squeamish-81713e94d079@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-haziness-squeamish-81713e94d079@spud>

On 08/21, Conor Dooley wrote:
> On Thu, Aug 21, 2025 at 10:36:06AM -0300, Marilene Andrade Garcia wrote:
> > Hello maintainers,
> > 
> > This patch series adds basic support for the Analog Devices 
> > MAX14001/MAX14002, configurable, isolated 10-bit ADCs for multi-range 
...
> 
> Something gone wrong here? There's already a v9 from another ADI
> employee on the list:
> https://lore.kernel.org/all/20230710042723.46084-2-kimseer.paller@analog.com/

Yes, my procedure for finding parts for GSoC projects failed to find that set.
From quick read of v9 thread, the reason for that not being applied was lack
of detailed comments about device data transfer handling?
Anyway, I guess the only thing left to do now is see what can be taken from
Marilene's set and applied on top of Kim's one.

I'm sorry for this unfortunate situation.

