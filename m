Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449C765613
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGKLvU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 07:51:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33350 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfGKLvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 07:51:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so2909973plo.0;
        Thu, 11 Jul 2019 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YADbvn2K6/u8nqZ8q9ZPF7M9RWPIMSzuiJIm7lkbc3Y=;
        b=dR8W5eRiA/e3yOi4FOC4uHJMU1ECzIkaS4bxgdBNsa6BXDCrKbvda7odCkmQbvNdcH
         YZoMSxJR0BYz3/xfoJkaYuvvI1fPrP/ynaRDty9gWT67FWK53dMGLMMlKD/njJJnwG/2
         ev4GNOw3od3Y/XeE6wdIhqYSrJSNF5oqRiVH634uOV7zxQMZMoJ71+aXW0u3rmgbG0OL
         92E9bCnNpG9Ool9BikbAnYOLXmoUL1PxCXFNTVbkxD19su5nmpC3Vjiv1unpY8nDw+zF
         k7FSnjPt3kEPNECLpxet7RvOHLPYL8wx5xQ8ETIxs3tM5xk8hgLMIr9b/A2K6AIpD8Zm
         J8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YADbvn2K6/u8nqZ8q9ZPF7M9RWPIMSzuiJIm7lkbc3Y=;
        b=cfxQCez6+MQm+8vWcQaygU9GAqHJ5s6xft/3h29iiLdvySp2pDYzyQt6PgRO7c3sP1
         QpgbmkoUAPYYe5UDqXBiuNi3UNpRuApUCdHAmomqpWJXWvBzqK+eZ3VHOdRqosEOOiKn
         dlKVfOQBWZyYUlYFvAbgN55qu/1p5UIihiTqAuiHbEtJaQfH+jmd46jxv97TgymuyBC5
         UIjWWFBKBlUzrPtIYIa8ol0q472ztXGE4RBtzEffuYwk26Jvm9eHzstrFHaJtim5flJ0
         DvCR4qgZNKVTpKIGtHfd+PbW6U3kHJZyvYYtkP+zJdaju6McUaaXCbnvOSDS57b6nM0d
         22EA==
X-Gm-Message-State: APjAAAU2nTO7Pwc5Fh3Qdjk9sCEjhL9QT7+y39bZUxox3TbCp+U/5YoM
        iCmaElTDdxhQqccyGJ5vXkA=
X-Google-Smtp-Source: APXvYqxcGYiazPJSNg+VJyMqpy0EBBHqn2dYQ4xvLYGpGoGXyLLw8DgEU53NFyfiW27LNl5svYK7jQ==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr4200056plp.221.1562845879704;
        Thu, 11 Jul 2019 04:51:19 -0700 (PDT)
Received: from icarus ([2001:268:c144:cf11:d03e:81be:e250:5da0])
        by smtp.gmail.com with ESMTPSA id a21sm6426357pfi.27.2019.07.11.04.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 04:51:18 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:50:59 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        fabrice.gasnier@st.com, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
Message-ID: <20190711115059.GA7778@icarus>
References: <20190507091224.17781-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507091224.17781-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> Quadrature feature is now hosted on it own framework.
> Remove quadrature related code from stm32-trigger driver to avoid
> code duplication and simplify the ABI.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

What is the status of this patch? Are there any objections currently for
its inclusion?

William Breathitt Gray
