Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6936CD8C3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJFTAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 15:00:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40173 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJFTAU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 15:00:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id e205so4310784ywc.7;
        Sun, 06 Oct 2019 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Us0YKrblQgRWQeQuWKfageTMytCoGjV6GZJUa8EZKdM=;
        b=vCBiJc2l54U+LpFa1SuZysYnPwwhlPxepmSDVBJYMdVb6Q7hWJbhJ6eSk63Jnb5TK2
         7+gUjyeZAjWdiXGXKgcylByeMsqKQVjAGQQeWPN5wsj3o+BkrZd3YceuFfxhWuXlGrdH
         lOicOIy3jZVhGEe9IrQnww/T38JLbfkVl88LLh/JSwcd5NS+axKNag6QRJEHSa3KsBsc
         Wny1HAeTld1/jLWNuEgFaR/IyBuCCQd9ahnN4tg398OslAV9sH1rmKfPO/SQOt1pDRbd
         N44zn8xCkvmaY8LpqKnGP9Hl2ByQ+I8+v0veA3xCahyZPEaBRw+7o0DyV3sU03DcQhmX
         /wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Us0YKrblQgRWQeQuWKfageTMytCoGjV6GZJUa8EZKdM=;
        b=cua0dAPYO48WCVH+3aDUZoV7rZokiYbFIVR6J3Ue+o9dXbGpHktC34c7kvLtsQzc39
         KjiZ/fDvYdIY0LBHZw4LcVhNDXW1z3O1OL/Y3bG3vxErC9GCxjHW8+FLaOnJiEZeHnJP
         /XrUTfdIh60vRcm6OuN7pNz5cL30HNYFf82lv8KxeA7xZPmmw5sl1OQEQXfiX3Ku/oP8
         a4uPT7SyMbKc/lD6ijDj8cyvkzi7W1gT4tgARVGv3K04Ew8dNjAej9V4IWT/2aPaMdUF
         7MmWbnYAzA177VeOFv+XAlrYewNp8bkq6wm7izChMYXUSLR7fUeW4avOBeC/jH/T3rlt
         VOKw==
X-Gm-Message-State: APjAAAXsQQFrtWxKTgSjtbPUlFNEh73EZJ4e0nnFVj9vsE1FIzsGQEOE
        hWu29lvYtK4G93lIL0HiWsg=
X-Google-Smtp-Source: APXvYqwdTQIpeCuBbpBgsgUkoMbPKwFrUZ55vm0hSSmZPHtZGSP1k/+YTPKGlaAuUOJDEyzp13hpmQ==
X-Received: by 2002:a81:178f:: with SMTP id 137mr18588158ywx.487.1570388419603;
        Sun, 06 Oct 2019 12:00:19 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id j17sm3315602ywa.71.2019.10.06.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:00:18 -0700 (PDT)
Date:   Sun, 6 Oct 2019 15:00:04 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org
Subject: Re: [PATCH v4 2/2] docs: driver-api: generic-counter: Update Count
 and Signal data types
Message-ID: <20191006190004.GA109365@icarus>
References: <cover.1570377521.git.vilhelm.gray@gmail.com>
 <75a9ca9837f4d66cb4912cfa535176e27f7c219a.1570377521.git.vilhelm.gray@gmail.com>
 <9850a671-2822-24b7-3c22-b4abbd6a6b37@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9850a671-2822-24b7-3c22-b4abbd6a6b37@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 06, 2019 at 01:41:42PM -0500, David Lechner wrote:
> On 10/6/19 11:03 AM, William Breathitt Gray wrote:
> > Count data is now always represented as an unsigned integer, while
> > Signal data is either SIGNAL_LOW or SIGNAL_HIGH.
> > 
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   Documentation/driver-api/generic-counter.rst | 22 +++++++-------------
> >   1 file changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> > index 8382f01a53e3..161652fc1025 100644
> > --- a/Documentation/driver-api/generic-counter.rst
> > +++ b/Documentation/driver-api/generic-counter.rst
> > @@ -39,10 +39,7 @@ There are three core components to a counter:
> >   COUNT
> >   -----
> >   A Count represents the count data for a set of Signals. The Generic
> > -Counter interface provides the following available count data types:
> > -
> > -* COUNT_POSITION:
> > -  Unsigned integer value representing position.
> > +Counter interface represents the count data as an unsigned integer.
> 
> The previous patch looks like it is using unsigned long instead of
> unsigned integer.

Thank you for the heads-up. Actually, this section of the
documentation describes the theoretical representation of counter
devices, as opposed to the in-kernel implementation of the Generic
Counter interface. As such, the phrase "unsigned integer" here means a
natural number and not the C language "unsigned int" data type.

I'm going to update this line to state that clearer since it can be
easily confused in the context of the rest of the document.

William Breathitt Gray
