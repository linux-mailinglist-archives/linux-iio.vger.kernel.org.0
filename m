Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4755C3E3BC2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhHHRAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 13:00:22 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:57864 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230169AbhHHRAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Aug 2021 13:00:22 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Aug 2021 13:00:22 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 4B3C01809CD9C
        for <linux-iio@vger.kernel.org>; Sun,  8 Aug 2021 16:51:54 +0000 (UTC)
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D6620181D302B;
        Sun,  8 Aug 2021 16:51:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 684482351F4;
        Sun,  8 Aug 2021 16:51:51 +0000 (UTC)
Message-ID: <b52eb842e1c681b88dbffba262075957b9741262.camel@perches.com>
Subject: Re: [PATCH v5 1/5] iio: adc: ad7949: define and use bitfield names
From:   Joe Perches <joe@perches.com>
To:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Date:   Sun, 08 Aug 2021 09:51:50 -0700
In-Reply-To: <20210808015659.2955443-2-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
         <20210808015659.2955443-2-liambeguin@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 684482351F4
X-Spam-Status: No, score=1.32
X-Stat-Signature: ddw8bkdreeyu6mbshx3jbmc5jirr99wu
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/tA4iFDvhMsYDj0WcE4jvt7feIyi5W9k8=
X-HE-Tag: 1628441511-89359
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-08-07 at 21:56 -0400, Liam Beguin wrote:
> Replace raw configuration register values by using FIELD_PREP and
> defines to improve readability.
[]
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
[]
+#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)

I think the naming is a bit confusing as it appears as if
these bitfield ranges are single bits.

> +/* REF: reference/buffer selection */
> +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
[]
> +/* SEQ: channel sequencer. Allows for scanning channels */
> +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> 

