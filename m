Return-Path: <linux-iio+bounces-12652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE039D8D69
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35163286B03
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992E1B983F;
	Mon, 25 Nov 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Op8YMp9L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A78181CE1
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566779; cv=none; b=sLNaeSb7CKtfqXW0iWUMXCeYM13TKJAJQ3IN4PyB6ilzbGKU+GjdsaqTbkYodFcJpQPgelgGE90uUrXXcS7b5+RJqNLq/ecv7Pifo8RJ4sR7aROjHRbCadx0OEAbkxMVRmflD2fAq5jNrdKDctFKhcVi0+8ITwFM0C44+cO+qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566779; c=relaxed/simple;
	bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSpwBYjeACR7oQzK1O4exwomvzEez0yMsKwYFkPZQa53+CrUURXgWyrE5zkVsZeR48JHm4Vl57bTwSqtT/ot8bmdvzWT5GvIiK0JGrzIoE4m84YB7sTkw8M9HaLs4FOifO6889bmGol7QBBB43tLNckSQzwMqSrNU1700iU3CQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Op8YMp9L; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4669eecd88dso5697831cf.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732566775; x=1733171575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
        b=Op8YMp9LvZkvQ331y4bCyUoMgneAK4i5u+jBCunnzEJlJtW7xclLb5OohO9SumbGuH
         4fzagqywBItP63EQEvhmEan7XlTD5/JleLrJRmTaipMburMKxgd/YCJCMM9/L2QEziD4
         HpOESiJdHYHgYEXEH/kBHz/lU0l52b9JAspQISBhmCNIKHWwXvoMMqQk/DicZHoejCO5
         zQXsb2cRo2wenRwFqtlgKSG3rep6fHGdD1vCpHNf8gPmWmVWyDyeN2BwPaq4dXAlmODk
         nF0UE/M1NPDRwd0oySNSQRelrxTjCRJLsMjSVAg0dONu1dA4RW6vchF8OyK6zA0iEuk8
         hCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566775; x=1733171575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
        b=tWAeCb2sLwqdZgFT4DnK0Qls6rhUGEF7dwakBTevltJIE6QxKqj+U1KBj6AG3t6XoL
         pV4aKFWFpKoXe2olX45HEGqTiQaRcfETw0qeTVKBer1Jb3xUrmehKC7e45/PQkQgeG6Z
         +FABrjY4lGKLZLwlAXxu8OUXWlp9orukSUUVhuN+QBpWAGF0HohY5kVvHq9nSWx/NRlQ
         3wf+JRI3FFocB3WKqyHiQhZw7RWkCKdAOy2NZ0LtoH7wf3kXc7dO77QwCM6L18y4cgdA
         QMVOkQXjC2EJsh+wfSvl8SMy4nsZOFtTNuVmLNQ2oPxbEiNXCY4JZhNcyWpCBTCIR0S7
         io8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvxrCA+Vta/lu1OmkIkxu4g8+eciJsW+iVwGoOSSVho7h+pOaNUXGJyH4w9WBcNC4zQ+WlVCNvJ3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2IGSUywC+LOxvNGoZtN8w3Nf3RIizn1nA4jiCwOl9X59vqVJ
	qinMQHqKrQtXfN2RZWSQ8I/ZjuSffijy8+bGOo8vo14SJScFJSpiXnx7eN1Gat4=
X-Gm-Gg: ASbGnctj8wm/DJ2l7xAlXvxQHO9PHV1O+tw4MotN9eK3u4nf0EBkzDLWHZRAAhYj+Wm
	ElstVNh6xZ9eQfD2zMXS1SxJWtFDKsBg/9mAuO10DLvCXZbG1BZ2Ymhco5QIkHoGUlv1Ki76Cfm
	5kdneZfgbenmsCJ9McdeKqaY7osZQ5B2IxfAoOsfqT53u0ttBop0PBkylPAxojXrUaqd7MyVTDY
	8CMBkjvJt9yNvkvyFRBZPOIIEvOsQqnBuOQ2Q/IprDQey11r9IoQL5rnNhTXjTNtP9BBH8t54Lq
	HhvHAVw8yqoFAVyuuQ==
X-Google-Smtp-Source: AGHT+IEW9gv2vT6TO3UrG3Mp0xF4g8i0ni2R6v2YWMJWAyLYNClNECvhkPWXuRBlO5lRIOzWoGjeVw==
X-Received: by 2002:a05:622a:190a:b0:461:3653:54f with SMTP id d75a77b69052e-4653d538d6fmr215091451cf.11.1732566775491;
        Mon, 25 Nov 2024 12:32:55 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466a43545besm1887821cf.83.2024.11.25.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:32:54 -0800 (PST)
Message-ID: <23038c4b-9f9d-4a47-8c28-89893027322f@baylibre.com>
Date: Mon, 25 Nov 2024 15:32:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: adc: ad4695: fix buffered read, single sample
 timings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
 <20241113-tgamblin-ad4695_improvements-v2-1-b6bb7c758fc4@baylibre.com>
 <20241124125206.1ffd6e6c@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241124125206.1ffd6e6c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-24 07:52, Jonathan Cameron wrote:
> On Wed, 13 Nov 2024 15:52:58 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Modify ad4695_buffer_preenable() by adding an extra SPI transfer after
>> each data read to help ensure that the timing requirement between the
>> last SCLK rising edge and the next CNV rising edge is met. This requires
>> a restructure of the buf_read_xfer array in ad4695_state. Also define
>> AD4695_T_SCK_CNV_DELAY_NS to use for each added transfer. Without this
>> change it is possible for the data to become corrupted on sequential
>> buffered reads due to the device not properly exiting conversion mode.
>>
>> Similarly, make adjustments to ad4695_read_one_sample() so that timings
>> are respected, and clean up the function slightly in the process.
>>
>> Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
>> Co-developed-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
> Applied to the fixes-togreg branch of iio.git. I'll rebase that
> and send out a pull shortly after rc1.
>
> The other two will have to wait for that to cycle around to be
> in the upstream for my togreg branch later in the cycle.
>
> Thanks,
>
> Jonathan
Thank you!

