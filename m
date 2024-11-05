Return-Path: <linux-iio+bounces-11923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04129BD124
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BA1C228E2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742F14F119;
	Tue,  5 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tytZ95Uk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574014A611
	for <linux-iio@vger.kernel.org>; Tue,  5 Nov 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822099; cv=none; b=jDcbIpBjhi13iClBgIShq+TaKPs4P+sbckjhtMTjxSUOQoCBEzoaPkzer8zdshZlcpwKCf6zFzj+7ZFFCEIOV3vqAt1F96SZbm4yGrxuHCYNB/qhCkgGi/E7lTW0QGRmqiBReaX6fccfMfrswoy6RW6sfYKfj+RvgrqP4l3TFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822099; c=relaxed/simple;
	bh=hyWtsIgGDAniL3p39e/pGqovDCo9zE+kY2920F3jbl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWZCHMdl0dJeCOn5FzTnbjMLgxtwGYDAMnoH7MW6/YR0JFvZHEHlOnAtU7jT29/JVeZysLjLCjAmSh9I2CVX1q+1cddXygUYs5PbYr9aaMn/xXfLBXLykCH0uMz4jfsQisEc8HEMaM3YGxHkxmd3XUGFItE5Fnzv7rYlhzX9+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tytZ95Uk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so3830426f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2024 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730822096; x=1731426896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3njGTXhIv0MvCjh27pJAW/MEoJztiS2FVGTmfPZr0ck=;
        b=tytZ95UkcLxm3LnVpQcAafGv7w2v2sodsBCAsc5RwzD8ga/sokXv/31OnVPSXAc7d1
         fj65cssnh/f2NX6Qg6LBTLh/S3fxjJAxZmbVIB1oXjMF4cd+QC0j7N0REOoFhPalcbXf
         x+aximUVMmzECOTFAejYyOosaUvCnFYXZVzWUw2lx6lfGK9HQySJRaSqyk8vCXLtnnn0
         vnBNSvWd/awy3K06Vg5LqlXyqMgFIlXM6PSh/tDXDKX+19THnf25KCrbMk/r89IuXBFt
         tGOWpr0624gziUs5gXfuQaM8SyfuPLUj07WdlybCoG7yYIHPRDAmi6PoHDx+DUbMBcYl
         xg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822096; x=1731426896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3njGTXhIv0MvCjh27pJAW/MEoJztiS2FVGTmfPZr0ck=;
        b=s29XYgbZntpEWhha3KOECG7Z5BLE+hxse5qzZC4XIQGnrV23w8kKPuNMLgjl1MBmux
         0moOh8qtunyz80uDpipFBB3PGJmRQR+oJbypPzdAL/FDZQG0Bxi/GaSOnCzf4fiYhLaS
         CtP/DN3B7qrXb5FW91WQr9zWwFscCY+GRXicMT3gfMqmM7uTZDwwKvQAzIjKnH90ucCT
         loq6CIqDt9T+PnMA0IyIJOWEUuizhCM65u4lJHbeYxHy6wkkFApq4kL+Fz24EK/PK6Oy
         MgWz06ZTZmuhiNAvDxBpbhAwLXPqIyAiH3dF6IU9zDNb6Nh8G2pSYd6P4fx1BMwPAjWG
         RAaw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3fEb3A6Zct86tqZMno1fRQ7g6kv8Wbt2lR+bXRvfKe/pdRkX/iUXldSlrberY+1JgRGE/f/SF3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWC0hyXZl+9XIDzFLo/t7WBBnyICmVxH6f1/Z13gWkEt5dxdo
	y5aFnpl7UdujfF3AVdadclrbNZ2DcbQ7KCE0eLDMFH46YS3DCpyf6rjrKYRcY55uRMM6z11bErX
	i4lOgDg==
X-Google-Smtp-Source: AGHT+IF7rnb/L+HIkfYfKE4/bBO2tPxiKGqEVY92wIDxONH0zhaa6XG02B8P6pUs+dM/p/GLFXJvgQ==
X-Received: by 2002:a05:6000:118c:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381b710f70bmr16642600f8f.56.1730822095676;
        Tue, 05 Nov 2024 07:54:55 -0800 (PST)
Received: from localhost ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40casm16558370f8f.27.2024.11.05.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:54:55 -0800 (PST)
Date: Tue, 5 Nov 2024 18:54:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, cristina.opriceana@gmail.com,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH 1/2] staging: iio: ad9834: Correct phase range check
Message-ID: <1405e340-db97-47f8-aa56-5f507ccd821a@suswa.mountain>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
 <20241105140359.2465656-2-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105140359.2465656-2-quzicheng@huawei.com>

On Tue, Nov 05, 2024 at 02:03:58PM +0000, Zicheng Qu wrote:
> The phase register for the AD9834 is 12 bits, which means the valid
> phase values range from 0 to 4095 (2^12 - 1). The current check uses a
> greater-than condition with BIT(12), which equals 4096. This allows an
> invalid phase value of 4096 to pass.
> 

I tried to figure out how this looks like to the user but I didn't
figure it out right away.  Please add this information to the commit
message.

> This patch corrects the check to use greater-than-or-equal-to, ensuring
> that only phase values within the valid range are accepted.
> 
> Fixes: f1d05b5f68cb ("Staging: iio: Prefer using the BIT macro")

The Fixes tag is wrong.  It should be:

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")

regards,
dan carpenter


