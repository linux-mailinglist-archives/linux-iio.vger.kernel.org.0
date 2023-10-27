Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E17D9DDD
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJ0QTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0QTD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 12:19:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DB116
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9e072472bso18288565ad.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698423538; x=1699028338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twpA4kPTjPdlQanwemh5B6a0NpYFUbg/0uFl1vufWFs=;
        b=OLUjGzOXJ2tw9AcnRVY6HY+c8Xs70HO3JLR2kVvG7dWhrTHHcnUklj2HFTNULvzvwk
         FhFnjmSeUkeeOmZBO+1x+aRCIsJJyVNdk9+XAdWyO7dBnWuxph23C5AaQ6+ZvYkjKArS
         lrmeuvubU+EWEmAh6j9xfqWACO8HPnDfb4UkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698423538; x=1699028338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twpA4kPTjPdlQanwemh5B6a0NpYFUbg/0uFl1vufWFs=;
        b=KwjnZpwn8UvTl+9irEsri5thXf30QNgFr3GKO7r5s0VUi2kCXXPDYBHvgdbSaa5js7
         YqTyQHmjLyrTobmblb2gBZ3MzqRZBlhhwmp1sTmtMq/HUvs5K9MI3CR14hqV972D+pup
         YpQLfkLDXqO5xcmrWviVW3XmHwrBthXBWNbwK+SFswkG/SIB1aK3LoEX7F8bTgJF0KEx
         BaUXQgYb9ydIX2hMIXdSsZa1Am/7YYZr7VErexR3a3aLClTJMps9/EXnNp19+8LZuBDM
         Da2QdjpyFBvov2C8GkBUDSmfWxJWy5q1lu6nVMm0+VBUYIJwWaxnpo8smkTjl8J2OvMM
         qAHQ==
X-Gm-Message-State: AOJu0YxLN/cxuHXYTP4tONwoqgZLS20HyXYfexR2csOZMdn3jVdd9Y3c
        NgZO4oBwt+WbLxg3B8LaF8TFlQ==
X-Google-Smtp-Source: AGHT+IFwV7PcaIlnwoiOO9E2bXJCkNVNwxIGikMfCb5e1x9KlANhbH020bPHG4aLV7W6zssgNv+xCQ==
X-Received: by 2002:a17:903:2309:b0:1c9:ece9:53d2 with SMTP id d9-20020a170903230900b001c9ece953d2mr3515237plh.61.1698423538314;
        Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170902ee0500b001c625d6ffccsm1759643plb.129.2023.10.27.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:18:57 -0700 (PDT)
Date:   Fri, 27 Oct 2023 09:18:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
Message-ID: <202310270918.EDE919D348@keescook>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 26, 2023 at 11:53:28PM +0000, Justin Stitt wrote:
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
> 
> For the case where a format string is used, let's allocate some memory
> via kasprintf() and point prop to it.
> 
> This also cleans up some deprecated strncpy() uses [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a reasonable way to go.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
