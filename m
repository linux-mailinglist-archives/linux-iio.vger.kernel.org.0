Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28D7161CE
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEGKSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 06:18:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 06:18:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so8413038pfm.11;
        Tue, 07 May 2019 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8pBOHepmnJE1/KzU1bAO4V1FlfT0xpTPU7pMbXBSIs=;
        b=YdndEbZRVbfd6JyBmK3pprG9Tj5uVoHj96dazYWHgaGCvSG9YackGco1b+A+QwJsbo
         2IB2Aw7AFIlHUyQQC8OO/PyGaFsdl3a+Ui0i9jS+jmmybLAhKCrIMdroPMTkQ4BW4r1J
         XSWyDl7hgLw/Es8QDdli57it39JXrJgf6xEww/UU0Hu1MQ8k/YIfVupnm/ShMrbpS40i
         TKaQf3XBE204zQnuxlm1FjbqkYCb/c4oOboF9mZGIDj6wFWS3BAOXO7ZYcUzlP4MtSsH
         wcYN7m+dzyRII4/Z/8oiuJ4u3KTWDHMSyqpYRZGyhveY3ro3kPT0yKrdQtrjvIXjMhrU
         OYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8pBOHepmnJE1/KzU1bAO4V1FlfT0xpTPU7pMbXBSIs=;
        b=iUVvvjzOdMaLqNhgpuEYVxYlcY/A8gJ4b/9D0yQFli2InhXG2kM2hFioyDtyI7M29V
         mzDmLwksFLtX+2TRDCriu51/uWZsU+Ahv7B6XgZ+DrME1qqhrJAkC1Xpq4vZ+CXHCSPX
         EXI3Ot39TsEL3UnPUTTVfvx8Dn9RgZJfS1kvO7/oRgcNGrfZXVjQZJop6ZiU1mgXmUBY
         rkL6lgBBM2ZMxyMWZIpw/A/pR8f2/LLmtIKG2A4DejsDUdjWqV4NVjlwh8J09hmCBYso
         HOqQx1kHQOTc+JHdZFjhZi28Nc3gTJAC2DzWIZ2cpIemh866IPYWtxLzV3EgUULOmSwc
         jFxA==
X-Gm-Message-State: APjAAAXzfkVllIiNmthDuXKOZWEWcCTXa0ZZqC7PYFNQdyPgsloZaGXD
        GwA6Q00YqEToKhWccqH/eXk=
X-Google-Smtp-Source: APXvYqw0MpKiLCvqwe8N+6fugyXUfcfqbZxka1Z+eJC2FrcXxk4z1+/4iDtrJjM2rg8zYe1KAD/hYw==
X-Received: by 2002:aa7:9ac4:: with SMTP id x4mr14324313pfp.43.1557224333621;
        Tue, 07 May 2019 03:18:53 -0700 (PDT)
Received: from icarus ([2001:268:c1c3:2283:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a6sm26288248pgd.67.2019.05.07.03.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 03:18:51 -0700 (PDT)
Date:   Tue, 7 May 2019 19:18:29 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, fabrice.gasnier@st.com, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
Message-ID: <20190507101729.GA3420@icarus>
References: <20190507091224.17781-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507091224.17781-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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

Although this functionality is now provided by the Counter subsystem, we
should keep the IIO Counter interface for this driver intact since
existing user applications may depend on it; this is the same reason why
the IIO Counter code in the 104-QUAD-8 device driver was not removed
despite moving to the Counter subsystem.

Once user applications have had enough time to migrate to the Generic
Counter interface, we can consider removing the deprecated IIO Counter
interface.

William Breathitt Gray
