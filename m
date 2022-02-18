Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD94BBA36
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiBRNkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 08:40:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiBRNki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 08:40:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E829693B;
        Fri, 18 Feb 2022 05:40:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m27so2870001wrb.4;
        Fri, 18 Feb 2022 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GafMyxIWmc4jQRLJIu37KnZfUQv6P8zM1b/LNvntbUA=;
        b=Cwpf1rGQNNaBjj8uN5Iz8V8VJimuKe/SIXiUcYmHL3kAmqPF6KBhxpeFa9nBVkQhCr
         j1luzT557/a6s0m13CZin4aywwCzzWzbnWyTdIqVN5esv63nBbvHrUShKfZ2xjBuTXA4
         Ih9OURpjjhQe9La2y4/KdQTLGM4EVW4ewndChcx9nmwUY/Xq3WgoOLXxPOHDFsztfubC
         vHyGBb83M8YPXN4tVC1C+bNHqPByQCEpetzFs0whX8pn2/pepUqnJhMwOUeo1/oPWPdG
         fYgP7zmnvPb41rCMMXzyKvqwORQZhBlWx79s4XQ54vyWDAFNB4+MFiOxqwqWJoJ5GpCJ
         9e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GafMyxIWmc4jQRLJIu37KnZfUQv6P8zM1b/LNvntbUA=;
        b=2x4Mu8ls1I89e8bEZ65bo8aziBYJCW9rArih5w/jVfqxajWsE9Tn1ZNYgVnbgrx1Dp
         rl+rGizxBSRn4mFQlKsf7vkG2U3vvDwrVjyX3kyij4JF638Lb2LlBs85YYa9uRNITAXV
         O9Wc8dZ2KKYM+XpLZZ84Lbgw+OUchjPhfT37U0f2tx1htEVlIoYm0N6HC64WCY4v+D8h
         GWeTcKs8z+kcO4Qp4MqkPfRmveeX9u/y/iIWpi5g4WmppWCMYHu+vbK5v7WQ8wxpwx5c
         WSrordjtQNS6n57HolVZqGBxiZ5gIxKRLnfazKNFCpKOcabHz1oR5L+ymrrg2EsaodSH
         CXSw==
X-Gm-Message-State: AOAM532dgAPbQHXxIIfaeXZ0RuZwwAwdhj9B1qLLdpqji3acUbSp3ciR
        kF2vx/J7hl2u3SvsTG9xk20=
X-Google-Smtp-Source: ABdhPJwdtCVMJWGY6BQSdkSSMYQg2m/W2LFKHvjOXkIXcMwNI1+zjPnJ/ioaioc2fNN6C/0NsHvlpw==
X-Received: by 2002:a5d:6cd0:0:b0:1e3:11b3:418c with SMTP id c16-20020a5d6cd0000000b001e311b3418cmr6105638wrc.405.1645191620722;
        Fri, 18 Feb 2022 05:40:20 -0800 (PST)
Received: from ?IPv6:2001:a61:2b1c:9001:b4fc:bdc6:aa9f:ec65? ([2001:a61:2b1c:9001:b4fc:bdc6:aa9f:ec65])
        by smtp.gmail.com with ESMTPSA id t1sm50247776wre.45.2022.02.18.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:40:20 -0800 (PST)
Message-ID: <0fdb9ce85efc251a0f461f25d5cc361ec70af8d7.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date:   Fri, 18 Feb 2022 14:40:19 +0100
In-Reply-To: <YgpeGZYTHWlmVZEU@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
         <20220121142501.151-2-nuno.sa@analog.com>
         <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
         <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <YgD91zg4L1S5KH5k@smile.fi.intel.com>
         <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
         <0fc9da519df96aaeb3cdcd155fb8aabbdc17fbeb.camel@gmail.com>
         <YgpeGZYTHWlmVZEU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2022-02-14 at 15:50 +0200, Andy Shevchenko wrote:
> On Mon, Feb 14, 2022 at 02:23:01PM +0100, Nuno Sá wrote:
> > On Mon, 2022-02-07 at 21:19 +0100, Nuno Sá wrote:
> 
> > I would definetly like to have some settlement on the above (before
> > sending a v4). It kind of was discussed a bit already in [1] where
> > I
> > felt we had to live with OF for this driver (that is why I kept OF
> > in
> > v3. With the above, I cannot
> > really see how we can have device API with also including OF... If
> > I
> > missing something please let me know :)
> 
> Sorry for the delay, answered to your previous message.

No worries. As I already said, I'm not doing much till the end of the
month but I definetly wanted the device vs OF question settled before
starting v4.

- Nuno Sá
> 

