Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868A1143282
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgATTjG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 14:39:06 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39728 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATTjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 14:39:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so225979pjt.4;
        Mon, 20 Jan 2020 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLo58FMuGoMdp6w5+M67QbJxYW/QcIQpDswNunuEYsA=;
        b=B3MUc2xN1OEp3r4FUlX15bbX7A+0DqEcz3mHSO0uGswMgozMs5wAI0Q5IC5O4ckaT3
         qGZr3G9+Pn5Gff8A6+DUdN+FUr5zY4zKynyBEKgNdBQbMs/4C/MqGeAGGLAcC0X4h/eF
         UeKu/pI0zu/rYOEOrnawOVASJu/s3Mw7spnGtNhpsqFwx2xoDch5TyOsmpLI9XbRgwMP
         UC82Wb3kg1IYdVQpYL5EVT12MCAB2waDZdzRhG5t7Qo4KbSdLJSFEFmNLlkoiNpN+y7w
         QmK492TMklTqnnPrdSZSv4a02xJZK7sBcaIPA5+Jgwxbo1uXmUtLGCjziO1yqv9rUxcu
         vufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLo58FMuGoMdp6w5+M67QbJxYW/QcIQpDswNunuEYsA=;
        b=HnUrp6A87V3TmH1Zyz7OrokbZU84D/vXlnFcr5WgQGYnhOSCh3P81P/zeUnbFdFwqD
         TNohVzY54/il9mR0JGSHofLJnO1qE0SyKJpFTbkXRSBOon3LxwehpKIUU6N/WJEG2nAF
         mUgmP9JmXFfWE3cQ+bgSJKcV+CBl/7OhMS/zxZFIqcmx4jtLDcKnMdeUUjMxfMDnyjnR
         oqSg6n9Sv9APsuqcC4gRRUw93AAvO90hjqw1dYgZf0fMQjMmU0Vun3jW453y5bjXDOW9
         vhL2LhPJwPGg6zsbemUU8Oh7uf+ulTebdIuVfMb9P8QhzRpqITykz8r/4X14qLT97ImH
         3i8A==
X-Gm-Message-State: APjAAAUkM0O2s1ONYz6cnrh9QbnbCC9RxhJQZpHWVhxO2/bEj3oMVKoY
        qKAFD02Bf+KimTGbxVzT35WvJekv
X-Google-Smtp-Source: APXvYqzfiglB9XCPBri33HNxtDQfYGPxIl6uFmhnlOz6wjpagQnug+4agaHE7QwHfOMn5XRmEUTYFQ==
X-Received: by 2002:a17:90b:145:: with SMTP id em5mr682423pjb.20.1579549144936;
        Mon, 20 Jan 2020 11:39:04 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b12sm39714158pfi.157.2020.01.20.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:39:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:39:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] input: joystick: Add ADC attached joystick driver.
Message-ID: <20200120193902.GH47797@dtor-ws>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
 <20200105001639.142061-5-contact@artur-rojek.eu>
 <20200111115440.35f6cbfd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111115440.35f6cbfd@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 11, 2020 at 11:54:40AM +0000, Jonathan Cameron wrote:
> On Sun,  5 Jan 2020 01:16:39 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> > Add a driver for joystick devices connected to ADC controllers
> > supporting the Industrial I/O subsystem.
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > Tested-by: Paul Cercueil <paul@crapouillou.net>
> 
> Looks pretty good, but I'd like to see a little more sanity checking
> on probe that the channels are in a format this driver can actually
> handle.  Given we can check channel size and consistency etc early
> it would be better to fail to probe than just report error data later.

Artur,

From my POV it looks decent so as soon as you address Jonathan requests
you can add

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

assuming you want it to be perged through IIO tree.

Thanks.

-- 
Dmitry
