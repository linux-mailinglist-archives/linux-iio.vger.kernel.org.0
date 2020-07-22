Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6C22A1BD
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgGVWDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgGVWDF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 18:03:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6682EC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 15:03:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so2003330pgc.13
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaSJOjYxrri/7FmsO8ASKIWMQQUaS+fP22lTbIs6vnM=;
        b=dvmV07cXBvU6pa9JHOugLBmCAKGJXy4Xyt8SZxoUsDxFV9w3dSWHQf4J6HLa69AgJj
         0myf2mTZvNtY6UIVyfMdY/7IxQsANIuxGFColh431YPOU+jni/LEusYzTaW+N1xg6EAz
         IoDC+yzkEEFUg1qQ19d5uxvi6kFcJNaBQnZwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaSJOjYxrri/7FmsO8ASKIWMQQUaS+fP22lTbIs6vnM=;
        b=Y5Jwmn8dFuAR9RRu10llKbfRS5A6Yx45aJkOPJHYPZt4Z85r3cOuDheOp9yRp6SjeR
         lUh+d49ZNne+dZhg0OAcusIG7y1EO/pcaLUg7w8m/VTSxo4B+eCRFLn70ZrYJa9QPyKx
         x7fvFK+HPgCw7Th5FF0J2brxyTCoWYoa0NRdUfU7pMquByFzy9g8+/xHJSBemYnRaXJK
         skA323ypLZ/PvbiNkPCyad3ohpUeYw/GqFedNwy5XdimeTT7JergNY3k6iUNj9nrsrN5
         unxJTsCWql9w4XpEOcehnWk7ZfQZzl8604rwfTG0xKWorLUlCIrATnMHCrpdYbbTanqg
         teQg==
X-Gm-Message-State: AOAM531jXmJ5ESmkPTuqeHnUx3ObogVMYe4gVH46T3HJbUIi41oaQ3vS
        Bi+mZI0tLViCMUHW962+M8U8og==
X-Google-Smtp-Source: ABdhPJzYFIwq2FueKwSGHZWrGPt0BN+iM2QiUgijkXljAolj8IoZVaJFJqNqA1mLxhQ5Q+NyNkO8Cw==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr1505287pfq.26.1595455384828;
        Wed, 22 Jul 2020 15:03:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id o8sm618049pjf.37.2020.07.22.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:03:03 -0700 (PDT)
Date:   Wed, 22 Jul 2020 15:03:01 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 0/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200722220301.GB2137556@google.com>
References: <20200720202243.180230-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720202243.180230-1-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guenter,

On Mon, Jul 20, 2020 at 01:22:39PM -0700, Guenter Roeck wrote:
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

I did a rough grep to see what you might be missing:

  git grep -n EPROTO | grep -e cros -e '-ec'

I think cros-ec-pwm / cros_ec_num_pwms() might need fixing too? Boy, I
wrote that, but it sure ain't easy to read...(*checks watch*)...4 years
later.

Apart from the notes already made, I think the series looks good:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Feel free to CC me on v3, if you want another look

Brian
