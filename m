Return-Path: <linux-iio+bounces-3827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34A88DBCC
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9584B22CB1
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E052F8E;
	Wed, 27 Mar 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1Vk4wvi"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA252F6B
	for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537328; cv=none; b=Qdikb+iKV35V9bjsqcQ2ffvRyuXnXRp3s6QHHndwE9Y0mVBba/9MzwpNS0EwsrOuSp/ZuTqufWjO1qz9+C062c7SNLpCQhFljEr3dm0wDe56Jk5wEWI7iezHeR786Phr2s27v0RAkgi6BimDzgUrqOq1h2RGPDrPwPdGYXlYvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537328; c=relaxed/simple;
	bh=uYsGK5lEK9yIgeZyD3k558dtA/h9hsNzKa9faW91jhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r07TosrTbi98SR2QCS85kfSPYzKh7qJFkdlHvVysheOI/rHfyLG1qE0eNzQri/R1YgUaqTOI0zZD8tj5jYDGbx/R6y5X1Vn9+G4UNtQW9O8OJv4LYpUpyC331zEEhPkcFCeKEfbRmLfk6Glkkyt6ZgcLEahuRsSAzdO07P5Bdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1Vk4wvi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711537326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWIm9qd3yJOQJ7NmYq6gWC8ihnoxW2PESp7UoE7JPcw=;
	b=e1Vk4wvix+Et7S7cHPUTBAmBtIWJpeWh/j/EwqCWmNTgon32BW9TFBWD82RAjuaV2hqx/M
	JYCz9kSpbLPMAtBp5AOPzaUUVQVkOgjtW+CT60aQG9ingXt4Uk0XblCiwOZUEPwfQRduaD
	6hvtBcV7uKlqKm0AAaeVKE6X6bbWXLA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-YuksAaphMLeUMBGFKcQF5A-1; Wed, 27 Mar 2024 07:02:04 -0400
X-MC-Unique: YuksAaphMLeUMBGFKcQF5A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4dfdbdaf06so56803466b.3
        for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 04:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537323; x=1712142123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWIm9qd3yJOQJ7NmYq6gWC8ihnoxW2PESp7UoE7JPcw=;
        b=WtyWnNTJqK0Qrfv6bQ1EvwxLnonafX4t6vTtbFAh9/ZyYA6uUCE8dcY9tC9G1JMtup
         9MP/n38i/nJUOqBbzUvh433uuuQAr9YWYUQLfCwNpC3dxzy1kTYB8Xj4ggqQ1NFwS0qK
         5JeBsXxHZI5AUAv/WyRyiiX12QaXWYJvQQPpuxrtr+G1jM8iXVNBSoLphXC79n4USYak
         yE9HY2zhuyQnq4RRq6bKqPXAPuUaJ1TDPhaZ6Fl3w9SYBgpmvLqtLngUEXsRt6gdNixa
         nkJBVyUTc15R5ezGYUG6ME99L5XEwi9bFm6QdKovjds46Y/UlASY89hmqd4f471M/SVN
         gBug==
X-Forwarded-Encrypted: i=1; AJvYcCU3ey452oMCS3sGKkTZ15GfWnI50mnUyPKfMvqcQxdWi0/v+gcLmbjfIeikqLMK5Qb6CjtKEr0Xqz6ZkrDNSh00uKagmeH3/i+H
X-Gm-Message-State: AOJu0Yx40frYBPX9OkiXfzPQqf269UOzEQVf3GAuKrcWzT+5vCgCA0EJ
	Wdq6rdrfyNWbBMxraVSiaMFXbKT7RZdLp1yPGftUX1avBYuaX6CWn3tnsjYdiLnJ9/gEaciMz7T
	r4OBPsI9x6EJTaIKKKTFg8mzWsZpVtgnQgQH4P/eOZSN3YZRZ4xpnXfHnT9rSK4mfMQ==
X-Received: by 2002:a17:907:7209:b0:a4e:360:c979 with SMTP id dr9-20020a170907720900b00a4e0360c979mr1419241ejc.48.1711537323317;
        Wed, 27 Mar 2024 04:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvilD81Aqb2lI3fOUJumD7ZJHO/zRLOvR5BzJXyhfqGjMcKtUGtwEDr55/yYxWFCyqw1SaFg==
X-Received: by 2002:a17:907:7209:b0:a4e:360:c979 with SMTP id dr9-20020a170907720900b00a4e0360c979mr1419227ejc.48.1711537323020;
        Wed, 27 Mar 2024 04:02:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00a46cc48ab07sm5296891ejc.221.2024.03.27.04.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:02:02 -0700 (PDT)
Message-ID: <1cff2613-b403-4585-a51d-5468afc13a98@redhat.com>
Date: Wed, 27 Mar 2024 12:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] iio: accel: mxc4005: IRQ fixes + reset chip on probe()
Content-Language: en-US, nl
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Christian Oder <me@myself5.de>,
 Nikita Mikhailevich <ermyril@gmail.com>, linux-iio@vger.kernel.org
References: <20240326113700.56725-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240326113700.56725-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/26/24 12:36 PM, Hans de Goede wrote:
> Hi All,
> 
> As reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=218578
> 
> The MXC6655 found on several Chuwi tablets models works sometimes instead
> of all the time. The problem seems to be that the power-sequencing done
> on the board causes the chip to not reliably reset leaving it in a random
> state at boot (and after suspend/resume).
> 
> The second patch in this set fixes this by using the sw-reset feature to
> explicitly reset the chip on probe() and resume().
> 
> While working on this I also noticed an issue with the interrupt mask
> handling, this is fixed in the first patch of the set.
> 
> This is marked as a RFC for now because this is untested atm. I'll
> provide a test kernel to the reporter of:
> https://bugzilla.kernel.org/show_bug.cgi?id=218578
> so that this can be tested.

This has been tested now and works as advertised so from
my POV this is ready for merging now and no longer has
RFC status.

Regards,

Hans



> Hans de Goede (2):
>   iio: accel: mxc4005: Interrupt handling fixes
>   iio: accel: mxc4005: Reset chip on probe() and resume()
> 
>  drivers/iio/accel/mxc4005.c | 82 +++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 7 deletions(-)
> 


