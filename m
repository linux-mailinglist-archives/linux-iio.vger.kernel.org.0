Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7014F53C
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAaXdW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jan 2020 18:33:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45417 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgAaXdW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jan 2020 18:33:22 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so10131323ioi.12
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2020 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ChijQNeSygMOIiBqfGiSq2wlNXLnTaZ9Nyhp4udsy8=;
        b=JIWxTUI+1SF3ugFBPxVc0/fq5SlHBtOZxuLqEbLkSNWVHsZY+u+RvEoLNOnzZpaZlf
         gyq2HcFrbEZ/DXl8FU5HdC7H9YVti9EZzGxxfp2dVqSEiQD5LzF2TKTOWfRRRyv8m+a+
         Nttu7gtFMN63gECpaOImS+yueKiWrOewOdcGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ChijQNeSygMOIiBqfGiSq2wlNXLnTaZ9Nyhp4udsy8=;
        b=H3n+5ogWPq0isYW5oJaJRE/8W2VNveDapfkDzsTVak+oHl2V8V8tI3X6xlyM7ejfdZ
         IOvB1JRpyHg6nng/nKR5W95D8sncyaRnjY7gqlyGSuqzqiDouH51foPPeqb9UT9ploKL
         blUHM1lQpjqiJ6hNUU7uYNgxUi+2SYiJTOnAnKP2DkvhYYtkKdgwnQAg0T/v+FVTkMM/
         giStCKMneju4IUDwAOEjpmZBWERH01g51VBNtH7iQw56SFFbanQq9mXGayumCY0kz5Os
         7OFb+4QDM0OQDnL8DQ1vFZY9mdO4gCkclDHXpUs4zD0xyD/EmQ6qrzkEN1a8o5nwiDUR
         8lfw==
X-Gm-Message-State: APjAAAUv/72urs79Y0wnZewBBDXiYNHs56Q+lFd2ULoffr+ZQ9K+8Lxi
        2tlKwoCll7b6MSyRW3JIDs+9WQ==
X-Google-Smtp-Source: APXvYqx5MlhNODdJb/eRfg68qyeStR5KoP8lcg0/PEZAbl/moydcAQNYD0KtV0nv4zTs4CJe+djzpQ==
X-Received: by 2002:a5d:8b11:: with SMTP id k17mr10681085ion.290.1580513599859;
        Fri, 31 Jan 2020 15:33:19 -0800 (PST)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id v63sm3740657ill.72.2020.01.31.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 15:33:19 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:33:17 -0700
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: Add SEMTECH SX9310/9311 sensor driver
Message-ID: <20200131233317.GA208488@chromium.org>
References: <20200121150658.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121150658.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Are there any updated regarding this patch?

Thanks for your time!
Daniel
