Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92083677CB4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 14:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjAWNjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 08:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAWNjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 08:39:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0923D536
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 05:39:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d188so10371493oia.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3k/c5woQO7UO9XAwtL5oYuia/I033FJl9LPtMWbUw/I=;
        b=vSbAvgoxddscXidTzywHkp1IdMfrZWt1oyYfXhrnV9ceZ5nMu6oo2NaseNxD4d+Yhq
         4tb2BYs2VW9rHMsw5MCNC6hOt9L9gbVkqKljGzrHt1Pu0X8tC2da8uwKGKd2Whi7yVKY
         EAuRaBzXnJnk3ldFSlU9e2dlJ3FHqBddHno7uxqvg6Zrr5bvO+zOXbFrjfkev4g98WwI
         FYNIwgEZTjHBp/+KW0dMvI6nywckfpR8+C/ugE1glNWRRPmThFLGY/1aU4I6h5Q9sPYl
         zidG2ZHk1b3T/uajcuM/7ThobJP4gMjCnWkRdkQz38BLAcTYGjBLLQ7Xo5KbQrgaBDOM
         cmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3k/c5woQO7UO9XAwtL5oYuia/I033FJl9LPtMWbUw/I=;
        b=lyaCfLXpXRpZrHllZuIJtrfjijWVTsFJu+7B6MN/Ex1Lh6VLbOz1ARghFgQ3Krl4VZ
         cGmbzUvW6BlOzlKF329qhUGhhXtcV+glXJS8+Cc0Aw3EW/Z4+6hpu12VQlp7D1PMKOe+
         yvaU1LIxH+6tp8kEjgpC5aeFN9ay5I/klDA6izSqcb0quko5leU5Nyf+kC31i/asEl3+
         bsyGosimr+z3dfV7+k4se7IIby6FN9XOl7S2iRWSwTYXtYXip6UyDjOy4RzMINrpgLUw
         uGH7e0mLAgMXcGJ19Dc3D/GY9jxAknFNkk+8zD2tP8qeFpeRRPYlNS2qmA1UxLvq8xgX
         VeSA==
X-Gm-Message-State: AFqh2krrtUKj68Wq6qgki7JJuYDwnJviVhfLUXSWWcC5DoUxz+eWS/y9
        SKnDPCaHKMy+R+BUROUlCGuq3KiK/onAB7rK8AuU3g==
X-Google-Smtp-Source: AMrXdXuNuwfajZUf++uzfezHLqjyrYRxyFRy5gZOuEaa85cnEKeyCvfn2fgQ5hJerDCXwF74VCGoiSQyZHbaeJeC6Lw=
X-Received: by 2002:a05:6808:613:b0:35b:d261:2d07 with SMTP id
 y19-20020a056808061300b0035bd2612d07mr1215896oih.299.1674481180984; Mon, 23
 Jan 2023 05:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20230115173958.134201-1-jic23@kernel.org> <CALJHbkDKTFN6BT=MCA5Obg6K6jY+yhwCd5Dsa5Ayrj=Z1mLwEA@mail.gmail.com>
 <20230121180038.0609ca0d@jic23-huawei>
In-Reply-To: <20230121180038.0609ca0d@jic23-huawei>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Mon, 23 Jan 2023 14:39:09 +0100
Message-ID: <CALJHbkB6dHdE25+11y88DrLdrpWRa3hROZ6zcZRsqtQ5_YNCtw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: Maxim max5522 DAC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


On Sat, Jan 21, 2023 at 6:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 16 Jan 2023 23:46:35 +0100
> Angelo Dureghello <angelo.dureghello@timesys.com> wrote:
>
> > Hi Jonathan,
> >
> > thanks a lot, and sorry, looks like i forgot this out.
> No problem!
> >
> > Reviewed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Applied the driver an this binding doc to the togreg branch of iio.git
> which will initially get pushed out as testing for 0-day to see if
> it can find anything we missed.
>
> Thanks,
>
> Jonathan

Great, thanks !

-- 
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
