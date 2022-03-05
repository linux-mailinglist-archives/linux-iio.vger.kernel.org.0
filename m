Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E14CE24B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiCECkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCECkd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:40:33 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497124F868
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:39:44 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso11512802ooi.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R36Re713qn0x9bA4c90DctwTgMsTX5nCST5fDiXQuK0=;
        b=UsNDJp7sgWG5YqhEVNewuRSgDNXvyyRCPS/wsv7EyodRQscR0WUpCw2zc2z3xksEAG
         OSJjcqNEIIDhsQwSrU5irPnurMOk5fzNribJ1Fp9HrFOqkSDDgi5Jlv1DMFkJKQlQvLR
         loubkrTVYOZVt8iMPYES4Dd1yGgUSORiSn/3dIMYf2b6Ak5BG9m/L6RAPqVQjLMpEpCG
         P+4lF51wO0aeqiAONjJe7tyiFr3rBLAIN6ZHnDu8j5fwHRqyl9BbJCi/etyOcXRPdIlf
         askPNjhTTRHRbmYOOe3aWpnlXVxrCWL4OXUObZ9C4agBlovIECXD35YHsylNSv0JIqRY
         OsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R36Re713qn0x9bA4c90DctwTgMsTX5nCST5fDiXQuK0=;
        b=1ThJ64T39472HLWA60SlekuAiFViRkbaDjpvE8ITe3ordWRiTYphX2uy6w0l+pLNU7
         6Nux4Gp+1vWnjWFy65ZZQMKlMGzB+Whq1wnGFjeXURQLzt4rmK9s0HgQ+4ArqZWytaq7
         0xnnO+jM9I8ZJe/4OsTrGwb0NCYiLaaoRWIplTur0v95QeuPK19FcKjvQPmSfsydDz6Q
         jF7pSuB6U8rTjN6idokomVdn8yuUwWiim+YuD+Ws+vPmEvHwtUlHVne7E1DsJNbOiwSh
         t+xZ8emO0CXQ1N3qXxXlLZ6O+HrUPPuxYcxkooZi1KZgIvNkNH2jkoc3+Ldoj1Uwsno0
         wjGw==
X-Gm-Message-State: AOAM532Xy4HVRynMRg1gvjT4o6kdBJZJP1sassr4Nd2Nr/inWFUjNWzF
        rV9RKXOUN/n8ZdHIZabH5po=
X-Google-Smtp-Source: ABdhPJwGh6Vd3jLvUE71r4RwYlF0xmFi79mVGUWjfNBHTKOMG103z6bvsWBRkl0jm1iMINHFVbLX6A==
X-Received: by 2002:a4a:4346:0:b0:316:7659:3fd0 with SMTP id l6-20020a4a4346000000b0031676593fd0mr549379ooj.42.1646447983631;
        Fri, 04 Mar 2022 18:39:43 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b7a:7b00:70e:e3d5:be94:991])
        by smtp.gmail.com with ESMTPSA id w36-20020a05687033a400b000d75f1d9b82sm3119289oae.47.2022.03.04.18.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:39:43 -0800 (PST)
Date:   Fri, 4 Mar 2022 23:39:40 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7280a: Fix wrong variable used when setting
 thresholds.
Message-ID: <YiLNbIrWUC+LzL/A@marsc.168.1.7>
References: <20220226175604.662422-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226175604.662422-1-jic23@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/26, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Name of variable change missed in refactoring patch.
> 
> Fixes: 112bf4aa4afb ("staging:iio:adc:ad7280a: Switch to standard event control")
> Reported-by: Colin Ian King <colin.i.king@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
