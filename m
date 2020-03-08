Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7953817D3F5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgCHNvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 09:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHNvV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Mar 2020 09:51:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A9D20848;
        Sun,  8 Mar 2020 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583675481;
        bh=X8dWOYJs91h+opdJ6WGqxXj3yahy3sLflXZCnwu6mPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1xnULWxHc6VFtywIFWZxYUwDlTly6MXJ/Z30BOpDnG/cCrW1arzpQe84AIM3T4VB
         Ltr5oVNC6xrluFJ8symvJzqVh+DX+yWip+8DHhANtv3EZdVz4sTuUJgZ9xgyJAs0Q+
         sqaOCPyWmN5uVxwbQxIrOJDKGd/s9LOdTvijJwEo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwKt-00B2fF-9L; Sun, 08 Mar 2020 13:51:19 +0000
Date:   Sun, 8 Mar 2020 13:51:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 3/6] irq/domain: add a new callback to domain ops
Message-ID: <20200308135117.7c60c881@why>
In-Reply-To: <20200211131240.15853-4-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl>
        <20200211131240.15853-4-brgl@bgdev.pl>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: brgl@bgdev.pl, linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, tglx@linutronix.de, jason@lakedaemon.net, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, bgolaszewski@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 14:12:37 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the remove() callback to irq_domain_ops which can be used to
> automatically dispose of any host data associated with the domain when
> irq_domain_remove() is called.

I have a hard time buying this. Whatever data that is associated to the
domain is already owned known by whoever created the domain the first
place.

Since the expected use case is that whoever created the domain also
destroys it, the caller is already in a position to do its own cleanup,
and we don't need any of this.

So please explain what you are trying to achieve here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
