Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215A915D443
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 10:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNJCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 04:02:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNJCf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 04:02:35 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2Wrm-0002B1-Ur; Fri, 14 Feb 2020 10:02:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4117C101161; Fri, 14 Feb 2020 10:02:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/6] irq: make irq_domain_reset_irq_data() available even for non-V2 users
In-Reply-To: <20200211131240.15853-2-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl> <20200211131240.15853-2-brgl@bgdev.pl>
Date:   Fri, 14 Feb 2020 10:02:30 +0100
Message-ID: <87eeuxh789.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
> made available even if irq domain hierarchy is not being built.

Yes, it can be made available, but WHY?

Thanks,

        tglx
