Return-Path: <linux-iio+bounces-27250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCACD278F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F283E30141E1
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83032E7F14;
	Sat, 20 Dec 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaXUAkWm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F182253EE
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206074; cv=none; b=Nu9DqzDM606ewsXflQb/feK3MwxRYkaEjnXgAKUg5iXxTQFOTeMZ1nenB4ggWE4Ntf2od4l8OIwwsIJvzGKMjUg0aumeDPZviR2sVcdEWq9Kw5+OLM+rhoalkJpGlVE6DTSv0B9FAKfgKuI1oRCLwZfU38D6QqKUiIe7c9V0mAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206074; c=relaxed/simple;
	bh=zYIclOZgCl0ZOfhFHStfmpDiNwAuEu81x0JVjxabh88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6rvapwczQFYpuQbQf32YUzMGy2ruxjC87BWHJ9AenutnXZ2GSWgEgdr7G0TBgotR1ZmVPMPH9ft7MjdBPR47s8EgeXsOu2tLgO78uddh3HGv37hoUcfX19EpSjaIpmQojHxgdZt8JKKQBS/gi0IiGWf5NivEno6BdhclshwZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaXUAkWm; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so3206327eec.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766206071; x=1766810871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bn2q8IIyeumrRPVac1dicPR7zPs8ygyeBmiVwFiJBoM=;
        b=VaXUAkWm6y85ib24JwNGhdiCthh2lZciDmzs/6dFaQ0ccGrFQV5SjmM49plfVHTFPO
         4tTHcbdDJO6u84Tf8F4lMexiNOTqLA3rp9xmEhz+qwtcyP8k8hiw9XkO7pZddpWRFRyB
         HSCQzwP0QbLqgth2lWxM6tJsN3A4IIGeqsA0fvBeapwxcINkncqlLj4lkxJXaiIrY2Fe
         WgqX5qe5WdAJVt/ghS7zJ7eGiy+NIMB6UH41jHLiInovgiUNuQiugCvXtU+vLlnm/ike
         eWxM6MBCxY4EULR8AQbGiXiJROntVUqAsoBYazaQsowfUqNHQ/FwdeNM2elFlzQ0xcDC
         Rk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766206071; x=1766810871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn2q8IIyeumrRPVac1dicPR7zPs8ygyeBmiVwFiJBoM=;
        b=VinUpowD4p3VaDTS7fQ8ys2yBHUb5v1/yRpnsfIHihx2njq7BGriV90EajZsi5VrfD
         R8dBpI5E3l2m0DZygQj+s9nMGNde5VNo1n9cLJWuhrLpKI2eLvwwMgIxuskffMjIjaIR
         iDpV5g9GtQa783R6duLKNGb1Zo8JdEQNhXGgN0e3hilxKo+jLy1ENcoCZ6Szl1iR3oIQ
         VT0+gs7ZNPZEEC6HKBjEcshlk+jVF3JHssBbq3FOWTPVZOsxdVuzJt2huKHZefC0aDnc
         YYWIBaMl4KKGfefE8oW9KecWwkl8XyrbWC2+yn1EEsIqQIgFUrPaABebAx2qKfYzEO1e
         3e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/UczxT7EGt0ynAwp+P/DzrYxq1PUzJHWurwlZIqsgr3/RK1S0OVhvZSq8hnn8BZJ+iryrPIKBAg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpechqZOdSTDUCwIcQ6eYLMfDpEHxNJCingBlNvMwrKA98Acbb
	poCm+pSPMo0j2v0r/o6VxM05IwlDjSkb3cr9t1XYghBmxZUAezr1ii8f
X-Gm-Gg: AY/fxX66pIYk+wSZY5yVHJ3LjScpoQQP9ndTNf4bUky/X6i0DWb/+0TTsulwbulyrUe
	0ts17MqS7NHWkAn6yRwpMlqB+GlU15YKU/5QBeBi63ktuDLau6HPi9zH0jVuGlhInDkLCTfuZz4
	iQN+twYu1cnylrvG5/GIaPOtpiRBKcq7wHgL8bw4P8D573LboNTuA1w3+3XeyT1NUyoh/HiCsgB
	OsKoCjjCXs/TAxTgsFjAVZX0d/58mALNnrZl+LpPt7l7wUrlQtpz3xscelAwhyJf6Xx8OvLmWEp
	vhCiy27LtN9aa9mnwzqEmviXso4zqW0Ub+JeZqLitTT8AiVPnyaABMg/lkEnA7xeCTKH7GLSOSC
	e6/LaL2yH2L1umAr27JSAwfN/dHJXnn5E+eUsgOnPuSpocUkMlg+VKLmwfazbteGTEKBnwy087J
	yET7WWbLDjoFEpfjcLI30=
X-Google-Smtp-Source: AGHT+IF+6E+AHWTkWnukA4AV2mf/MQyKZpOlD5h2Lh5FY8EVVYHcw2vf1TZKzquPq8oZQDv7ALq/ow==
X-Received: by 2002:a05:7301:5793:b0:2a4:3593:ccbb with SMTP id 5a478bee46e88-2b05e591842mr6743671eec.2.1766206071103;
        Fri, 19 Dec 2025 20:47:51 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm11961233eec.3.2025.12.19.20.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:47:50 -0800 (PST)
Date: Sat, 20 Dec 2025 01:49:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/14] iio: pressure: mprls0025pa: make ops->write
 function consistent
Message-ID: <aUYq2tpt45cTjKIv@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-7-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-7-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Make the i2c bus write operation more consistent with the rest of the
> driver.
That's not the most appealing reason for updating driver code. Is the update
meaningful for a different purpose? Consider squashing that with another patch
that makes better use of the updated function. 

> Also move defines only used by core out of the common header file.
Do the define thing in a separate patch.
Commits/patches should be semantically concise (in other words, do one thing on each one).
Usually, the word 'also' in a commit description is a strong indicator that the
second thing being done should be on a patch of it's own.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/pressure/mprls0025pa.c     | 5 +++++
>  drivers/iio/pressure/mprls0025pa.h     | 4 ----
>  drivers/iio/pressure/mprls0025pa_i2c.c | 9 ++++++---
>  3 files changed, 11 insertions(+), 7 deletions(-)

