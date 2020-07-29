Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3E23279D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2W2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 18:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgG2W2C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 18:28:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B9C0619D5
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 15:28:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so2771283pjb.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HakOP25I3XRzn6emIyIn+SNaVVoDU428IKwQeNMWETw=;
        b=JnQqskZz2TH+OX/BxntmELHkDL8XBjDxamqluvS5qO71nT10lxrBAcfjbUiiZL6BFQ
         d9S8JEVN3ue1HfEEPzt83I/bjcT+s5b8i8c0PKB2MY4FI8xJAGzltx8kaJvx7MOtbIpj
         sebV33rN9euwB4owI+P9wXiXkvwTNaVit+UFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HakOP25I3XRzn6emIyIn+SNaVVoDU428IKwQeNMWETw=;
        b=UKE4aZxXY+Rh+RI97bhLHmMaQF72JVEJohoaUymI6HKx72+MrUNInAPXmsQOXtlhjz
         W270XzBVObLWr620/5Rsza5yxtHzio2IBBuO67vmwC70uwGcnkBoZIXWZFNcodJHI9J9
         yni1auN8JfWow0FXNx/+GSjK7ZQYrRSxB5Qm01U8Z4z9e9bfdgghprPaSbcJTmQuNRtx
         /WHT5bGDCKv37QLgezs9WxaM1iuMG1Vx41R2COFHEuyTuxxL1DOGM+no7TObhN40OD1F
         2w/FZPm26eYQRqtPgbVKw1p/jWJSCvDgnwup55vZ26C7+GIKwgFtcLPomFHXooFYNFAY
         muww==
X-Gm-Message-State: AOAM531TDA1PONxnL5LwAoouQEwYVNBTEtnGIUt93US3bbPbGQOTWWjk
        NEjrLE959kKpDytFl5xciyDglw==
X-Google-Smtp-Source: ABdhPJwDfwZlf3Y94wXlvwwOetYjB5EwTN8SUq/khGfqIu55ajJehBwt91Ox5CU2A2OKvfKlTL4C8Q==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr30361526plb.325.1596061681297;
        Wed, 29 Jul 2020 15:28:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id a16sm3647844pgj.27.2020.07.29.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:28:00 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:27:57 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 0/6] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200729222757.GB970863@google.com>
References: <20200726220101.29059-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726220101.29059-1-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 26, 2020 at 03:00:55PM -0700, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
> to Linux error codes to report a more meaningful error to the caller to aid
> debugging.
> 
> To prepare for this change, handle error codes other than -EPROTO for all
> callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
> -EPROTO reflects an error from the EC and all other error codes reflect a
> transfer error.
> 
> v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()
> v3: Add patches 4/6 and 5/6 to handle additional callers of
> 	cros_ec_cmd_xfer_status()
>     Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
>     Implement function to convert error codes

A small potential (i.e., being paranoid about future changes) note on
patch 6, but otherwise looks fine to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
