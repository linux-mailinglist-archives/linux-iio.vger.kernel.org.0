Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E854F1543
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbiDDM4x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiDDM4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 08:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B00627B29
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649076896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7oPoHpR753mUEaQDFGWtJcBiuJoSf0bjw6p8TVCqQs=;
        b=VQc04Ll59xkjs/fx4DV4kEwEVV3JuozaNaJye/46q7cFGvixADdx6r++QuVHMwauME2n1x
        40vdaO+6IE1soe+I7PcbGTf/jIypWady3Ks/zTG8aWL2+Hj/MOu19Ny+aCPuQmCDiiG3Dx
        ZzkE5+bdYfvFl5o1wOyxjx5AfPsyJ8k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-FSfRq2RHMoKJ88SEwBPkJg-1; Mon, 04 Apr 2022 08:54:55 -0400
X-MC-Unique: FSfRq2RHMoKJ88SEwBPkJg-1
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso4442222ejc.22
        for <linux-iio@vger.kernel.org>; Mon, 04 Apr 2022 05:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J7oPoHpR753mUEaQDFGWtJcBiuJoSf0bjw6p8TVCqQs=;
        b=OO08Fg8+8OwpgmZ4TNkIO595d/Pi9vSTXTch1/wBp+zoI6qbAZpnY5hQUmVXXZUzjC
         lxXuRU2ZUcDS66Rx22omrYkOGRKTj8dnQ3ZBL8YpJNQK03BLn/dk/KEYFM5MOrn9Pypr
         82vHZYlc/vrFJmy8zWDy2ymv6hFXywS2DvgqAVawVUy1E82WtbYuf6QA0O/uLentBEe7
         0R8G3lrzT0YV4s1H+SQRg8dbWBjxDaxZDt4Y6WJ62weAgo3vHagMhbPn1bEBa7gV0zPf
         wXpU/lBUxBgyYUt58DZJVhwOv/gs4pD6K9tq75y1JQkRIpaJXUqUHNWk9kZtHPdNauYn
         feAw==
X-Gm-Message-State: AOAM5338/2j1tUVMMNyQROGhirKcj75qgZXEPyDoLXPte5nqX7RlDZ21
        AOAC63q1sTqhRv3KafYj1usuqzpBLBuFl4ORBWo/8Tef0YqC493cpHIuzDgr9jdiRK8F30YI23u
        n+DKG1sV+7X2PWUJ9MR4J
X-Received: by 2002:a17:906:4786:b0:6e7:f7ec:632 with SMTP id cw6-20020a170906478600b006e7f7ec0632mr2276291ejc.751.1649076892791;
        Mon, 04 Apr 2022 05:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvov1jpOKaeEwyUrj0fOsPGoGjwYppw++2R0YiyHa8nXrQANmD5A66X2w1avIYxZlkSKY/Fw==
X-Received: by 2002:a17:906:4786:b0:6e7:f7ec:632 with SMTP id cw6-20020a170906478600b006e7f7ec0632mr2276262ejc.751.1649076892536;
        Mon, 04 Apr 2022 05:54:52 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090600d600b006dfbc46efabsm4323463eji.126.2022.04.04.05.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:54:52 -0700 (PDT)
Message-ID: <4df1fc93-2a2a-3482-085f-3a88970440ff@redhat.com>
Date:   Mon, 4 Apr 2022 14:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: unexpected indentation warning in
 Documentation/ABI/testing/sysfs-*
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
References: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/4/22 13:58, Bagas Sanjaya wrote:
> Hi,
> 
> Doing "make htmldocs" for Linux v5.18-rc1, I get new warnings:
> 
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote ends without a blank line; unexpected unindent.
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition list ends without a blank line; unexpected unindent.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.

These 6 are all fixed in this series:

> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.

https://lore.kernel.org/platform-driver-x86/20220324164737.21765-1-hdegoede@redhat.com/T/#t

Which will be included in my next fixes pull-req to Linus.

> <path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Block quote ends without a blank line; unexpected unindent.

These 2 are fixed by this (pending) patch:
https://lore.kernel.org/linux-kernel/20220324165918.22005-4-hdegoede@redhat.com/

And I also have this pending patch for a pre-existing warning:
https://lore.kernel.org/linux-kernel/20220324165918.22005-3-hdegoede@redhat.com/

I'm not sure who should pick these 2 up ?

> <path/to/linux>/Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

These 2 warnings are new to me (I tested with pdx86/for-next, so they probably
came in through another tree).

Regards,

HaNS





> 
> Introduced by 2546c60004309e (platform/x86: Add Intel Software Defined
> Silicon driver, 2022-02-11), 2bec6d9aa89cbe (docs: ABI: sysfs-bus-nvdimm:
> Document sysfs event format entries for nvdimm pmu, 2022-02-25),
> e8a60aa7404bfe (platform/x86: Introduce support for Systems Management
> Driver over WMI for Dell Systems), 40452ffca3c1a0 (erofs: add sysfs
> node to control sync decompression strategy, 2021-12-06), and
> 4c18a890dff8d9 (iio:proximity:sx9324: Add SX9324 support, 2022-01-01).
> 
> Presumably because Sphinx mistakes these documentation files without
> extensions for .rst files? I dunno.
> 
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

