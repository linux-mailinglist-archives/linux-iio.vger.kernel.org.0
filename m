Return-Path: <linux-iio+bounces-11499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FA9B3717
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA691C225C7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B71DF24C;
	Mon, 28 Oct 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3ZL/9M2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CF1DED59
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134263; cv=none; b=Ln67XnTCML9/5+TpTgeF6W/CzXwaxucvTVmnDpwJZ+sDO4y6aEGY/T3lTuGw/vLeRp6j3u/tuDnBR5avOBvS/4P5Tu2HiVj/mtZ4QsdhqhRdBfa4UoSIR3BLW0v6Ehe/Wqolw9+XwdHfon2/Zmhfq+k0Bvj0AY8eCHFvbrPbIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134263; c=relaxed/simple;
	bh=YNoQvvMS5/D2v2YySWQ8RNDrxQrJsWqDk2LwVI2iMak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBl4BbN6/JVjL6li+CcZAOvVCFVWgYCZfMGJYvYuzmWHm+mKCnDVqXghDStijSAJsehE0Bas5163P4JQI6o8jJW969nIs28MYZRcrP0UIVzB4lqITN6Us2a1AsJRwh90R9YcxzEQTvTqHDwbz8b90Yu4ffOvWkiGaboPD7R6Ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3ZL/9M2/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288b392b8daso1917343fac.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730134259; x=1730739059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So5fw0V5qgR2UBoNFs0rsc5CZx1axz+g9Tri71Oo1jA=;
        b=3ZL/9M2/iAX1adTQgdaQIPyRJoS5Maj0NEQmNcwMVVh0iOXC1seIpP+8vg5+gwmRiZ
         BQpah43QvQxE3ckGfsi/A0FNO6wby7qCRHc2tiNp75HfSjIoKxsyWK8BVeowVnwWURsc
         TA0tmPI4oRRlRqrTitH85TaToMI0byYhWkmpbXX4+37Sa3luZ+YL76jgW3+pHnUI67UN
         JidVKbLHzLd64Y3UKNegWqsi5dM4LyddPW8DuJZVSSaJZPyxVMhU3VWIwOcUNxF33C55
         BC3O2/iwNBffM6D24bI4UTu79mFjLHdiy3PRwSXTZ6kuHJKu6U1hLBItgmdGeBlSjdzR
         pYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134259; x=1730739059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So5fw0V5qgR2UBoNFs0rsc5CZx1axz+g9Tri71Oo1jA=;
        b=BBKiLkZEQ+KPcY9Ozm+AEBI3f00UNslf0Osr5Gmxe9xM88ZXhpcMze+PzVM0cC3r/Y
         rVkNuQCauQw4KJCx3Jqli8GJJcGnQOD1AFtPogbC6YM3adcCNqJVrApakOCB6DDrALeo
         s0ecb/tvAELYOecw3hP/xaMY3HPFNWXoMXRuxXJMsItRhy/YaTHyRYvOjtFKO1euuARE
         yj7JujwfHB5yIYY3+aB9FOw3oT0dZh2UPMKFAGO8xAyEGkwxaZr2RtztN4I/hXbtus12
         92/tqJmHyoaIRCe58ZZJQMv8uh+P9Cbq3QMr/qR4uVM1xsqtDiI+hBhwOzuoSvK/j+rD
         FN2g==
X-Gm-Message-State: AOJu0Yz8eLxupYLYkimjZDWc8cbpfsFxC9Y+zDDSGzsSk6ZGijF8oBLB
	W1ISreCoVHhW/3kOM7CKErSWF8bG6J8awyR2TCUyJt+3WodscKk+03v1WYARyfg=
X-Google-Smtp-Source: AGHT+IHTf5Y8gWwEN+EmjM+XuERl5FU+xwKU+Ixf8xTy32EpCHlOJQdRNcvgTuT7gcWLD86pnLQhTA==
X-Received: by 2002:a05:6871:6a3:b0:264:9161:82e8 with SMTP id 586e51a60fabf-29051dcd079mr6645207fac.41.1730134259037;
        Mon, 28 Oct 2024 09:50:59 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2904394971esm1939131fac.57.2024.10.28.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:50:58 -0700 (PDT)
Message-ID: <a4efd955-9956-4040-be2c-9bb8e032d862@baylibre.com>
Date: Mon, 28 Oct 2024 11:50:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: events.h: add event identifier macros for
 differential channel
To: Julien Stephan <jstephan@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 11:38 AM, Julien Stephan wrote:
> Hello,
> 
> This series adds a a new helper macro, IIO_DIFF_EVENT_CODE, to
> specifically create event identifiers for differential channel.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


