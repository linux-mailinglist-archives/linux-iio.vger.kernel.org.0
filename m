Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44296154D66
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 21:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBFUqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 15:46:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34007 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgBFUqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 15:46:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so49508plt.1;
        Thu, 06 Feb 2020 12:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRRz/TTbJY0rJVFxdXphgTRilr7A8yPPTS0Uy1cOzYI=;
        b=U3V79h9TSWs2+NjyAZ5bXwbSOquZUDtVZr0t/Q9NV+sdq2PD7URT47FtyKjI4bUnDs
         MSpjr1+oN5QDeuOF7182pYXkzyBlJJeVUtCp5zUWcxetn3Qxr6SfxEJs5TWLtOgpRfCL
         QJb2BP0qStLdf9fL9+MmyWCg1S2tKnVX6I+scfOMX5tC55yTqcPoZUMTQeEz6MfnxseU
         ftB+wz9c61c9KKcK0VeTT62cB0aVbD9AdQIUyz7j0mJiIsw1QqyXzhVX3bqz22fLyADR
         KZeusHlF1g7v46CKG6uCyn7QhvzyzgQIy+6eYhOgVq2/OksEgy3jHyOex2EQ2KzLlpig
         HmYg==
X-Gm-Message-State: APjAAAXQGeQCXZCHAkgtJJgjfS4a+CBDusAI4JYb9NYAzD2tIjyK47Ue
        GNkWgbKEqv3WXY1QrguPSw==
X-Google-Smtp-Source: APXvYqw3i21zG8VchiKpwOClmmNNxvpGfIuuGeynfglACClOjdMJZK6wsS2Vbxahnpkys1QVUyi9wQ==
X-Received: by 2002:a17:902:8a83:: with SMTP id p3mr6197742plo.56.1581021962092;
        Thu, 06 Feb 2020 12:46:02 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id r7sm288783pfg.34.2020.02.06.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:01 -0800 (PST)
Received: (nullmailer pid 20625 invoked by uid 1000);
        Thu, 06 Feb 2020 17:35:36 -0000
Date:   Thu, 6 Feb 2020 17:35:36 +0000
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, biabeniamin@outlook.com,
        knaack.h@gmx.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Message-ID: <20200206173536.GA20564@bogus>
References: <20200129142301.13918-1-beniamin.bia@analog.com>
 <20200129142301.13918-5-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129142301.13918-5-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Jan 2020 16:23:00 +0200, Beniamin Bia wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Document support for Analog Devices MC425A Step Attenuator.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
