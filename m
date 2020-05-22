Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863A41DEC54
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVPo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVPo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:44:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106FC061A0E;
        Fri, 22 May 2020 08:44:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so1045015qkb.10;
        Fri, 22 May 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+FQlGAsd5VwEJukC1oxrls/cl2Y99ctG3ZXp8hKvbs=;
        b=plNTg+exkS5PfQQDNXUATtwZYGgHoTdkhQZWtd25vuTwvleATu2u0VuG0sGNdt3LTq
         sG2OZhvz6cGw/LA3RwHGeyoH5h3xVGh55FoK9r6XOBmWtM/mgznK6i2SHUhRt8b5Ek7C
         JkVOmjfhZ1McUGkaovz3V4nPl/v+ZjqGdw8nW0H0pEhfzW+bblaI8Xcnd9l0DA3Hojfc
         Qu+As385wBdNTSDY5qm6USyAgOfMxEN2ES7eVYPE7NHSyGjftitcUD8kSObmT5IXWVmh
         W/HYAixQCLNmp+NnmFITCh0SpQdqCUe70Z+Q3y8b3eli1AHSR5n76m7+kwKKQfdA+SjL
         Mnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+FQlGAsd5VwEJukC1oxrls/cl2Y99ctG3ZXp8hKvbs=;
        b=JND0030KVvuaO4TSxl5xUEZjbl41sHj04BHXSpYCuDP99nA46Lw/UZXZARvY85USyf
         65p/E63M/oo4S8oSALhmry8pyuxB2YJEkMuIvPN+ZRARz/v7E4+njfLvPRbzWOx9Ofy4
         dxykOBinZ0bpktTrPTghT1ybMD9UtRpM72aF/8Ysm3OvzwpvNw8y6Gz7OlMfsd61zQAC
         E3ZU698il1X/eGqrdERVi590eQ3nM1KIWIz6aN62HhSJJVn7xGztiOkBQmqB9b47GuiB
         19NGrhE28G/j3/4rz0/ejdHlH+F6NU8N1NqxFumEU7amUYakLmavQTWeSmf8R/UDVhPh
         kEtw==
X-Gm-Message-State: AOAM531ZehkMLjHOtNiDOJBFWwN/W5mEAGCbkeo83aScmROjjiC3KLY/
        l+VeFPVoR6Esu1wdpBSsBm0=
X-Google-Smtp-Source: ABdhPJwZ0ZdrTAQgQSMVyLAxZPwmco9HBD9BC5MVcgMoLCa24NcJUqNR/TMxCYF6cqdT9TGSotWeGA==
X-Received: by 2002:a37:644d:: with SMTP id y74mr8288509qkb.477.1590162265826;
        Fri, 22 May 2020 08:44:25 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id h188sm7692281qke.82.2020.05.22.08.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 08:44:25 -0700 (PDT)
Date:   Fri, 22 May 2020 17:44:21 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200522154421.GB21655@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519184933.00003f00@Huawei.com>
 <20200520072423.GF3361@ict14-OptiPlex-980>
 <20200521192736.4818f17b@archlinux>
 <20200522082208.GB19742@ict14-OptiPlex-980>
 <134f419f-de85-f14e-0331-49b8bb72625c@nxp.com>
 <20200522142633.GA21655@ict14-OptiPlex-980>
 <2cb64245-a3ec-b6c0-5f64-b2fdf6cd3689@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb64245-a3ec-b6c0-5f64-b2fdf6cd3689@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 05:59:11PM +0300, Daniel Baluta wrote:
> 
> On 22.05.2020 17:26, Jonathan Albrieux wrote:
> > On Fri, May 22, 2020 at 01:47:21PM +0300, Daniel Baluta wrote:
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
> > > > > > > Daniel is still active in the kernel, just not at Intel any more. +CC
> > > > > > Oh ok thank you! Daniel are you still maintaining this driver?
> > > I can do reviews if requested but I'm not actively maintaining this driver.
> > > If anyone wants
> > > 
> > > to take this over, will be more than happy.
> > > 
> > > 
> > > Other than that we can add my gmail address: Daniel Baluta
> > > <daniel.baluta@gmail.com>
> > > 
> > > 
> > > 
> > Well if you'd like to review this patch I'd really appreciate :-)
> > Forgive me for not having understood your answer regarding the maintainer
> > field, can I add you to this binding as maintainer or are you saying to
> > not add you? Thank you and sorry for the repeated question,
> > 
> > 
> 
> OK, so I think would be better not to add me as a maintainer because
> 
> this would set some expecation from people, and I most likely won't
> 
> have time to met them.
> 
> 
> Can you instead add the linux-iio mailing list as a maintainer, not sure
> 
> if this is a common practice though.
> 
> 

Ok thank you! I don't know, maybe someone else could point out
the right direction to take, it would be sad to drop yaml documentation
format just for this.

Best regards,
Jonathan Albrieux
