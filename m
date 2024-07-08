Return-Path: <linux-iio+bounces-7452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA992AAF4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 23:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728182832EF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FB14EC60;
	Mon,  8 Jul 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hrz3z6OW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE53399B
	for <linux-iio@vger.kernel.org>; Mon,  8 Jul 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473351; cv=none; b=k/q8QTr069sIIyd4+/0P0SCW/SKf1XV0Y7dqpK0/t/RYdPxHG3ZoY8EnUhaOGlv7MFKb4/kWsNkZVEZDQSj+ndefa+YX8QGIWARWtn8JbaRNqQKuwY/xRF28hP5R5phAoAMD1TCk+3dXdcmfRnkUw6ky0x4ZRsq+8pWHxMmVDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473351; c=relaxed/simple;
	bh=rhLMzhnBr1fmJn4hsQMzNNrDyhSsV9+nyDHGBNMD9LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEAT+8XrEZhEBexRYEHi6EN67nspxJ9y7yciiWUbKAOC+d1cgmf0/bmvI30/ABKB8u0RQiM1+Aa4CSnPKKVgdDvfH0mA3QOopPtH/4Y2ZSyjUz8HgJAG8PQz5fSyilLK8YhCYO6orIJZT5VOvxnl2Uch/eBH/U7sUOUPHMR4bHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hrz3z6OW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-703647385b6so1347966a34.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Jul 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720473347; x=1721078147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uy9ikK6i2ce0Lmsca9PL3vsPP0xYz4tW9STZ+9c+oE=;
        b=hrz3z6OW3ATt5CSB4mfO5xjFlxqwUs6Lo/q/HKft1Js9CilVhTs/Y4SGBf/dIqNMSq
         nsCYuBpZRNHDb9jyyrez8V/6qZMgIHz2EZn3ORg2SB17NxPMPKmWYhd66/LrCbQfbS+E
         /JVYjpIfQwnE3PxGZfvNddZSnCFoyOmFeiNfmcJVtvuV7tvADNdkJQraZfk3Xp/xBQyG
         F4HnMoaVRTkL7VchWJNgQq7VHxxTaG+AzgsI/xdwSLcod/x2s4UMHngt7frp2WjwytBm
         b0RcZTcQlbQ8eHGAHpLRaPEQeDkbh1UyP1KRIWQzf5hYlwyFA8RhR8e6gJcNd8KbmnMZ
         lxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473347; x=1721078147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uy9ikK6i2ce0Lmsca9PL3vsPP0xYz4tW9STZ+9c+oE=;
        b=w9Ide19LnFWBvsCxeiY7itGW4MF7FQNEohFfeEt5RbAxi0VCct5d3k0Bkf498C7ITX
         g4TDsctgDvEHF6B5e/tqoHj6MJ395ndQ+w/3F7rS7UWPpFRkoZKOsriU/77CKaYz+x5z
         0vFjNDwYeL0I/ITR21WI5TYAEIUgusgN+o0oizNpEQ9TccIdnwYeNA/24Qw20xovT+1C
         68okOFcLcoy6/RiomXV+JxAkL+bE2YnwpzJZJklnT++11UQFANLo3uxACiDkJimQslIW
         74BIbVcOLBaPfQYjycA6qXFto2kyHNkVpQV/xswwoqNJpwsx3YzwC4PmwGA+zv82qGrg
         ec8A==
X-Gm-Message-State: AOJu0Yx+10xJ0RWSYJrByQpBVbz1Nf3Ey/1JBpC576rQZyLUbD//LRnW
	Doj0ZYjZrZLVVt8GiqFQLT+qnN+piKCTM1aSxT3uTHQhz9KIx0diF+TAEew7D7U=
X-Google-Smtp-Source: AGHT+IFCFAiZRzRwOpzCyq4dZt7m1IKHP5ZbEcsTgsYyiNk5cHylYqzh4ru8zGjJ0H54yTk3AdBIWw==
X-Received: by 2002:a9d:6316:0:b0:703:64d4:8e12 with SMTP id 46e09a7af769-70375a06a12mr723275a34.2.1720473346891;
        Mon, 08 Jul 2024 14:15:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fc0af5sm157297a34.62.2024.07.08.14.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:15:46 -0700 (PDT)
Message-ID: <bc88e0c7-516f-4eef-a9d9-ce0250d6a570@baylibre.com>
Date: Mon, 8 Jul 2024 16:15:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:04 PM, Marcelo Schmitt wrote:
> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> (Controller Output Peripheral Input) for disambiguation) is usually not
> specified when the controller is not clocking out data on SCLK edges.
> However, there do exist SPI peripherals that require specific MOSI line
> state when data is not being clocked out of the controller.
> 
> Conventional SPI controllers may set the MOSI line on SCLK edges then bring
> it low when no data is going out or leave the line the state of the last
> transfer bit. More elaborated controllers are capable to set the MOSI idle
> state according to different configurable levels and thus are more suitable
> for interfacing with demanding peripherals.
> 
> Add SPI mode bits to allow peripherals to request explicit MOSI idle state
> when needed.
> 
> When supporting a particular MOSI idle configuration, the data output line
> state is expected to remain at the configured level when the controller is
> not clocking out data. When a device that needs a specific MOSI idle state
> is identified, its driver should request the MOSI idle configuration by
> setting the proper SPI mode bit.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Tested both valid and invalid combinations of flags and saw expected
behavior/error messages in all cases.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>


