Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5930F172AB
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEHHe6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 03:34:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44589 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfEHHe6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 03:34:58 -0400
Received: by mail-io1-f68.google.com with SMTP id v9so12488839ion.11;
        Wed, 08 May 2019 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=06vNhGWmXv8aMKwZVKHjsvRsD+uYUkrBPC/S7+NBkoE=;
        b=apWVfaiDZ1exPIwVVASJ59UGwhjBA1P2k6aCr1J79HXmlETcO4h4+8A3DyPvaXxtP6
         fw4y8+fGxb4LyrRdyX+6xiWjwG389N+mdjgKCCb4W7AVXEmhrcudC6rHkrGHLri0BdjL
         I4NTI4Y6kDVR9F9So8ZW2+jhqhA52TSCtIhHdf9uPULVaqUzAliGmBdCYqZZn+R9xaD+
         3UePL7TQHw3sRBUHY9X8AhEQurjjCJTYQ7WD/B6gu3tTQsJ0lqTKqWbvpSNpj3zo6Krf
         /UA+vaCQYxMCjOBotAe90BID+G/PPngIBiWd/w3YfQjLYX487puI1u8KsX/QtxyHLFO1
         e/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=06vNhGWmXv8aMKwZVKHjsvRsD+uYUkrBPC/S7+NBkoE=;
        b=SN9nV6k/TYFejxInHBmuzGPfuHZFj+G+bss0hAMeh8PcyjFB3kenU0/9AjZ45N5+/o
         28CnWXp3m9q16pMQc6EXUxJQaX+XJFGsAslL7w6fmxRra2wfdwO13WyF3D+mpslJ5Tmv
         PjqNQlFJytbLhZew5Ndl2lDtdaA1RaCiCdEXhZGYxPdWwHZ2K6VkXN09c3t5REA22JYh
         kmPVH2O75hnlpKijtxdoPToyeQ3rpo0nHf/Bb0bmEgDCeChhMywBr34KRD5vXMsk3P0f
         5cWTnakMdcSbefHSa9EGs9VmAMg1fUYKy9+jTcug+aaksT+/2vqt1jl6IRPU238/tOHJ
         ClTw==
X-Gm-Message-State: APjAAAVV8Q0HbN77WON1HGbByARBx2mLdEd80Oc9MiUYK4EouzUVorKg
        VQ22Agnx6TgNYb2kcSyGK7U=
X-Google-Smtp-Source: APXvYqwF9H/7HCZIz5Tn+Hj7eOSVa+HOFngsAGECdBjmi6GEuIUO3hqq+2bK57608GUBAZptqroXbQ==
X-Received: by 2002:a6b:5814:: with SMTP id m20mr11060978iob.293.1557300897335;
        Wed, 08 May 2019 00:34:57 -0700 (PDT)
Received: from icarus ([2001:268:c1c0:b600:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id 81sm799787itv.23.2019.05.08.00.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:34:56 -0700 (PDT)
Date:   Wed, 8 May 2019 16:34:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
Message-ID: <20190508073434.GA3277@icarus>
References: <20190507091224.17781-1-benjamin.gaignard@st.com>
 <20190507101729.GA3420@icarus>
 <CA+M3ks4LhOFTeArnh3d=C02qLJWj_u6tWDDOhD8kZnJPRkXC8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks4LhOFTeArnh3d=C02qLJWj_u6tWDDOhD8kZnJPRkXC8w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 07, 2019 at 02:37:07PM +0200, Benjamin Gaignard wrote:
> Le mar. 7 mai 2019 à 12:19, William Breathitt Gray
> <vilhelm.gray@gmail.com> a écrit :
> >
> > On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > > Quadrature feature is now hosted on it own framework.
> > > Remove quadrature related code from stm32-trigger driver to avoid
> > > code duplication and simplify the ABI.
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >
> > Although this functionality is now provided by the Counter subsystem, we
> > should keep the IIO Counter interface for this driver intact since
> > existing user applications may depend on it; this is the same reason why
> > the IIO Counter code in the 104-QUAD-8 device driver was not removed
> > despite moving to the Counter subsystem.
> >
> > Once user applications have had enough time to migrate to the Generic
> > Counter interface, we can consider removing the deprecated IIO Counter
> > interface.
> 
> Hi William,
> 
> This SoC is not yet in production so their is no legacy on the old interface
> and I would like to avoid to create one.
> 
> Benjamin

Ah, I see what you mean, this driver is for future devices. Do the
earlier STM32 H7 series devices have a quadrature feature as well, or is
this functionality only available with the new devices?

William Breathitt Gray

> 
> >
> > William Breathitt Gray
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
