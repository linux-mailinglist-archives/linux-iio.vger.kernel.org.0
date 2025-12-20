Return-Path: <linux-iio+bounces-27246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CFCD2765
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB546300F9C0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92465263F54;
	Sat, 20 Dec 2025 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbzEt9du"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC463CB
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205444; cv=none; b=Rtw1Z7FVIVDy0JULjiN1vn5ZQfYaR6AtdFFo/v6y5x7fG9K2c2YeV2+bj9fUFOhjqyYN0UOfhEMh6VSzNpSAClIp6RlrRs5fLAKi6QKY6f51l+L3dJA4lgLGo4DCzYKhGOwvV57/52kj7AMDOi8MBVp6HyGBcUCo2Z+ZD9TrbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205444; c=relaxed/simple;
	bh=0fCT3kqMkiERvtz4q5Xwzo70TFOuP13BPppq9eAradM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRyymNX9b2qvtc6g2IgfcmwEK072exCPCyW7ddlgI2ZiOlifebPDSzJjxIGWQAWVxvXaKvyqo1/p003YSUIY3anJuiLwutEEwqtn4jVshnP5PjfkUlsunyp6OhTW7qoHjz64Au/oFzRF5aNRD+OHoejstkb3ZYbDzYjw6kWZxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbzEt9du; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so2390432a91.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766205442; x=1766810242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLpjsYS6b/HREIYqvFQYx4gfCmQOuOwo9AdWNDOZ+Sc=;
        b=XbzEt9duTrMfJbqbbqrBrPiHz3ccqyMlx30W0ngWZl0e5BEOsHBIz3GvrapbtHGdEx
         CkJeO5rlN6fpwcSWyDiiWYYjFlbgkmh4BTDHh7ws2Qs4+gHgpDm7uy9nYRh3X/0fVvZp
         e34eCoEPoi8WxFRvIsW0/VlqwAmACIlMhmJBKwfO9hjjfuzqMdsWX+4nOYw+CC3Ocv6E
         KdcYEKbvkMHeZCtLeXYUTLTuYAqWLl2ndW2dIUZS/xnVXBXI6l8nbePGuTBfqsKgqoRq
         3umZMXffH7dVbMZCRUNDbWlLFC88tFpcKyfgKfSoy1KcIbzGiRLpuXOZmZATqjEzQ2zC
         /nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766205442; x=1766810242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLpjsYS6b/HREIYqvFQYx4gfCmQOuOwo9AdWNDOZ+Sc=;
        b=aUSbAWkdO/b1I5VDYa5zaKG3i+E7lfem0iC6h3h2825ugzQWJO7qNOVn2SUoIqdgcY
         MQY7JgAkz/D7d9TbYonFVdGgKm10wmRk4sNzVa4u34Me9LXK7rYc9T9TekwylhD5OQRh
         o286D4uosPm1/tsOdZg0nnlkGVYlGupKFYHdThMmqkCNKJDvyaqaWv1upJ9FCil2sgt2
         8uD/30v5wAZAAjcg+R6P1QejBnVl5E1aA29l4o4RkTN5QOTflZy3KaWPkCgYHQAsPmTH
         fejjbOe/UbkPYCdpGPCyWdJoHnI8vYXtiayfcLAPr7YQPzWC3loBPEbZ0jx6DUSH+e19
         7ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCWxwnBnZBIQ5h8RAjgbY57NKEJh8VtcjCxu1RmW59GHlUeQ9MM7hhEclAgom3TqVOuLlQGHhz/FYuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrWvCsahbPy6Va39sQOz/jHuqU/F45XVCawe67Ya8QGi5uVwz
	oDP65tDGIWsi5jpWyTzE+fGCcEDhHEKndvPGcLI6An2WFjJmzH7XdXMf
X-Gm-Gg: AY/fxX4XbwnPfw+GLQdpKgxCd6enSXWwzc+nEFNCnnacrgTBvCTuUyj2CCljzqAUI0N
	zPMHg2lXF33HQP0NdM/QrIK4vH2O5rPgHJgihOQnpDojSJlDPw6ZELnV/BzIAb6Z+GjYb87S1yl
	TMfEv/STHpHjHMQ5IJSxhnr7SuwU/0sMRuE3iHMhFS2fbwwSuPQWAt5PbjWwYGyNTAjFHynuXnn
	JN80PDts6nB18mcQ2QclKN7wZTVBr+sAdjRvOcd8eKfWCYuHKhBkr2vNUHbU6J+psEr9fLprSEc
	XI6S87U3gyzK7isCktTyAqfPDm67MhYDeRPpsoaCovvl179/k0xFkShcN7YaXndQsfqHLOaIa5F
	LcJGFx2HTeQ+/Esm1aQoeVwsNXMUGtIdU4WvbhNu5hAIa5Tmtaz5OB6cUrfVNCIm7wDYnprUJNp
	myulrR8pJ4ES+JbVFgYIbQpTZyBJnU4w==
X-Google-Smtp-Source: AGHT+IG/Qmlv7e2544fADXiwtyW7JdyYdhz2Luv7vYmbjDPy6wG0D6uxc8I2s6crfY5FGtsVidi6og==
X-Received: by 2002:a05:701a:c968:b0:119:e569:f27a with SMTP id a92af1059eb24-121722e9c05mr4023071c88.35.1766205442233;
        Fri, 19 Dec 2025 20:37:22 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm16502827c88.4.2025.12.19.20.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:37:21 -0800 (PST)
Date: Sat, 20 Dec 2025 01:39:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/14] iio: pressure: mprls0025pa: Kconfig allow bus
 selection
Message-ID: <aUYoZa90Sboso6eP@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-1-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-1-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Allow the user to select either the SPI or the i2c bus specific
> module and autoselect core if needed.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
LGTM
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

