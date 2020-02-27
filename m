Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2A17287A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgB0TUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 14:20:22 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:53443 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgB0TUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 14:20:21 -0500
Received: by mail-pj1-f44.google.com with SMTP id i11so135810pju.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2020 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvF9WN1ENmEWLFCB2Ie/CpOrZzOkm1mar5PCeVIzNjQ=;
        b=bhnLjpFjmuVhkbsryoo0Y4pGFqfdrqXLXpBlQSqEPI35xtBnSKGbmkowrhCux9KoyM
         aBQzacruImrPalQU7z+zaij7bfweCXHp5L7sy0/BpMqWuUCcjuea2v11XuwXte+I6UnE
         dHt/q3amSggkh5RPpgrfXR41x5eZDeLuQpTOxZc8dzVQwM486Z1MdlRzehBVQ/NZmQWU
         ggSOHidUN5NmaqqxShltfpWjob6V9xxtzqppwUL9mP6uNKPQxSwpnAYE/Exi8x82HAhA
         dRG0fc6dvgnNxlHp2/GtR7KKRNcW+kF/kFSk4QGDTAQmrpjNx3cgxDrjj8zCK9bquU28
         Ruug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvF9WN1ENmEWLFCB2Ie/CpOrZzOkm1mar5PCeVIzNjQ=;
        b=G2GFMqK5YlXHlrCmd3MCeEF+TjIV2R/avttVaisxJcMX3KcIKCg+MU4VQnDrGn7W36
         RVvAEtHNtHoE1HMdRqGeftgGiH5+w4Wun3F+yROAwxfBuXn7yLDgFwrN8IVx+hYBnnYQ
         4JZ8owLa1xNdcF0yXZIQo809bUQyU0E1G1sBudswrqH1NCOxiAYqAj8kjwdzOGMV80Aw
         xSn+Kap/7M9JkqM1BqIpe4jPViJMzMDA0e6m0rj0InYw0QVDSNrULMSoGlTb/mUwHL7M
         MsPH2l5V2V1WW9T+kw4ODahrW2KwuiEacq7k5HfKJnJzPN8jyxA6fo3d8FbIxVhqdz7q
         dszA==
X-Gm-Message-State: APjAAAVsbxa1ui7iQo+l1asF9BG5G8/g/v+UipfrPmv0TtHPFEkILL8g
        ogQjKAMyFUGA1zfRpiO7C7WHR9+kyMU=
X-Google-Smtp-Source: APXvYqw4kjB6uvL8obxDgho+M+PjXAAcvak320CoyIcrWVZmPgFZo2FkQX7pCdXkA/Fy89EHKN18KQ==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr289511plr.5.1582831220332;
        Thu, 27 Feb 2020 11:20:20 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id i14sm7190103pgh.14.2020.02.27.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:20:19 -0800 (PST)
Message-ID: <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
X-Google-Original-Message-ID: <20200227192015.GA20793@rohitsarkar5398@gmail.com>
Date:   Fri, 28 Feb 2020 00:50:15 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     dragos.bogdan@analog.com
Cc:     JManeyrol@invensense.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [GSOC][RFC] Proposal
References: <5e55473d.1c69fb81.82355.928d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e55473d.1c69fb81.82355.928d@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 25, 2020 at 09:41:37PM +0530, Rohit Sarkar wrote:
> Hi,
> I am proposing to work on the accelerometer MPU6050 as my primary
> project for the summer. The work items are outlined in [1] thanks to
> Jean.
> If time permits (which it should), I will be picking up other tasks
> outlined in [2] by Jonathan and Alexandru.
> 
> 
> Would like to hear people's views on this.
> 
> [1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
> [2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
> Thanks,
> Rohit
> 

Hey guys,
would love some feedback on this.
There are no proposals as such on the GSOC IIO page [1].
Was wondering if there is any new iio driver that can be made into a
gsoc project.
