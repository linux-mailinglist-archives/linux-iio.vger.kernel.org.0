Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73A3A340E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJTbI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 15:31:08 -0400
Received: from unspecified.mtw.ru ([194.87.146.52]:49351 "EHLO box.trvn.ru"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJTbH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 15:31:07 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 15:31:07 EDT
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5CF57403F4;
        Fri, 11 Jun 2021 00:20:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1623352836; bh=Nnba2g0dXUBlwXUC9BOq0xrDblpBfEu2+uPhlk9/slE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W7tTCEU+ONG1CsbvVLQ2rhuYQunAWBLWOlt4/KYJnrgRZGfbZu6gNsjz6RXwKwq4h
         UFrm27uM4YMMNiATcxNeBcD2AIoLYIa52BjDBM65sII5IfEyylnfe8qXTdA3g3Zevp
         YA2FE3YxP+JsfVTdayLl4Y1EwdZrP7NrgRXwkhP6IXHXq5cH4hj/gcegiC2b37opqU
         +RL7y0UUxVzryv26X1wprS8IaMmxUy1flnwPwIX0Ikjtg9fyAiiaOkFbTRI7+PQAbF
         8m3nTWlj3td46KJG4Sv7LZr/x2g8LwEZCiahSw9xsdkBqz0zAJmNDqxhPiKemVu0Ie
         XieDQ/FSC9pPw==
MIME-Version: 1.0
Date:   Fri, 11 Jun 2021 00:20:35 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/4] fix regmap, initialization of ltr559, endianness
 and mark structs as const
In-Reply-To: <20210610134619.2101372-1-mkl@pengutronix.de>
References: <20210610134619.2101372-1-mkl@pengutronix.de>
Message-ID: <5d237fb56774540fc525109d8e850782@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Marc Kleine-Budde писал 10.06.2021 18:46:
> Hello,
> 
> here are 3 bug-fixes (probably stable material) and 1 enhancement for
> the ltr501 driver.
> 
> regards,
> Marc
> 
> changes since v1:
> - all: add Andy Shevchenko's Reviewed-by
> - 3/4: move endianness conversion to the callee

Hi,
Tested this series on Wileyfox Swift (Longcheer L8150) with ltr559,
it works nicely now, thank you!

Tested-by: Nikita Travkin <nikita@trvn.ru> # ltr559

-- 
regards,
Nikita
