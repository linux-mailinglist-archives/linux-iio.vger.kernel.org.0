Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A681513CB84
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAOR7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 12:59:55 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17868 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOR7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 12:59:55 -0500
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1579111161250710.0911969793755; Wed, 15 Jan 2020 09:59:21 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:43:24 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma400: integer underflow setting accel scale
Message-ID: <20200115174324.GA29555@nessie>
References: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for taking a look at the code and your feedback on the driver!

On Wed, Jan 15, 2020 at 08:45:31PM +0300, Dan Carpenter wrote:
> We put an upper bound on "val2" but we also need to prevent negative
> values.

"val" is not used past the invalid value check. We only use "val" to make sure
that it is in fact 0. AFAIK there is no "upper bound" on "val", it should be
zero or we return -EINVAL. Am I missing something?

Cheers,

 - Dan

