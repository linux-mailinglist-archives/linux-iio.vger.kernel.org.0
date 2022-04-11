Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571F74FB51F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiDKHn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 03:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbiDKHn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 03:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BF720BFE
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649662904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TmjbFozbzx9+RXr5GKa9nSGj/OEk/e7g+nlMKSYDew=;
        b=XaWEWXpxAe1nmKG0DkSZO7+S1kg/rUAh/96spfLaIBjZBRG5p2UcdYjLaggzcK7RLQmgVK
        eBxmp/VtV6OVsjFMikOhbyLK/D5kGzDQ40jB+ZOxfk7AEVu0UjKSYZR0fiJDLQwJh+h0Kt
        PGdTxs59An9LheyrcyS//2tDtyk9Z4w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-GbGE5_mKMJe-pmfzoBpzfg-1; Mon, 11 Apr 2022 03:41:42 -0400
X-MC-Unique: GbGE5_mKMJe-pmfzoBpzfg-1
Received: by mail-ej1-f72.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso6513106ejc.22
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 00:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1TmjbFozbzx9+RXr5GKa9nSGj/OEk/e7g+nlMKSYDew=;
        b=c437XAVj4is19CSpxh4mLkx+zMW7z/qfsjmJp92BUE/y45pjNzSZhKkUXzQSqAYgbh
         lVLe6lyIw8j9v4wHxZ568Sc+GXsxO+XhxDAdz2QFkGZCNPYJBwjt+GtBLOLJv2orvbD6
         Y0IMTNila0Iyxyc3HiGEFEtbxverhHCX1ht+qwpDM046oxpEsgvWDhQPbVS65YsJTtgb
         UWG8jghq8B13VooNN/hEUCm9uu6DxxcN3VqA13vHreB2EoY1p3nAVaA3OT0DIp1usvC+
         u9JUdS0EkRw0qjcTLO8W07qPVvRPy+H758G3Klq1/eUGWLp4XaPDfE5vFyii16fi+DPG
         MeXw==
X-Gm-Message-State: AOAM5302zUWf2GmPAq3QGUWiD/EIOQ4sXcasUeeZRKS9JZFq/UJ1klJO
        ZPm9Wlw03c6Y23XLNqaNj4KNGK62sUcj45es6GiI6KkpzKeLpJdD7sBrZ3cVmfyVB0Ni+xIPcMI
        pOBj7VnCnMKaSGjhp690c
X-Received: by 2002:a17:906:b016:b0:6e8:7d1a:fe02 with SMTP id v22-20020a170906b01600b006e87d1afe02mr6622892ejy.403.1649662901227;
        Mon, 11 Apr 2022 00:41:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa6HKmgJuO78WTPKuveaOdYyNruYiyBTIrinDVz361B18T7IwK6rt/vBWPD27dtVBdkrHhXQ==
X-Received: by 2002:a17:906:b016:b0:6e8:7d1a:fe02 with SMTP id v22-20020a170906b01600b006e87d1afe02mr6622878ejy.403.1649662900926;
        Mon, 11 Apr 2022 00:41:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm14644626eds.21.2022.04.11.00.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 00:41:40 -0700 (PDT)
Message-ID: <92b0efab-39ab-7325-d625-b71e62b36f55@redhat.com>
Date:   Mon, 11 Apr 2022 09:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iio: accel: mma8452: Add missing documentation for name
 element of chip_info
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220410153317.290896-1-jic23@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220410153317.290896-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

For some reason your email is seen by my thunderbird as haivng an empty body +
a nameless attachment with the patch... ?

So no quote of the patch here.

With that said, thank you for the patch and the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


