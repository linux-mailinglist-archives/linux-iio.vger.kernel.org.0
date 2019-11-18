Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97B0100EAF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 23:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRWQn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 17:16:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46955 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 17:16:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id n14so16877151oie.13;
        Mon, 18 Nov 2019 14:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=31Fq2MhmM/Urm61qHS/zASd5hxG1Am9pqw2oaM3IrGM=;
        b=f21WzBNufYWesUh851UVTh0Ly6w3xY/ZkQ3gW9eR513JDIxu1jTaNHynamrrRc7vQ+
         i7w41PKFr2m4lKNvGp30gp+7UoinAOG1o90M49jTtwjLk6qVvG7hYx2l91flDw5M2JS2
         +RGy0O/Mn40OlPPgHjomamEZ3WDecUxiFxy2NdM9XCtw9l3VaZt4ifyDmwlYW381Uf+V
         WneXfXQ4MZqUmc/uiS/G8sleH1p2D6a6JmYimPkrGHxYEnLk1ZHxvano/XmiAm/lRwzU
         W/aSItQWhfhiREeddk8efEle0Ap2zJYruFak0NdZKyuCit5Z7id9LsJsb+Vj43k4sMHf
         pIQg==
X-Gm-Message-State: APjAAAUBnltlVjW77TMG0h1m50pEMoNkFRrnrslPAACJqbdIiNFI9uQN
        IQtJ/MqWt/jU0DZaZYGgaw==
X-Google-Smtp-Source: APXvYqwH0uCFhNsGiWA5jSWAZGCA4GvWT52jHanTph/d7N9nMnA7tMhfeBrI8QOtNcUZTsKqI/z6AA==
X-Received: by 2002:aca:ef04:: with SMTP id n4mr1115455oih.91.1574115401304;
        Mon, 18 Nov 2019 14:16:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n5sm6330647oie.16.2019.11.18.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:16:40 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:16:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     tomislav.denis@avl.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, tomislav.denis@avl.com
Subject: Re: [PATCH 2/3] dt-bindings: Add asc vendor
Message-ID: <20191118221639.GA2875@bogus>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
 <20191114100908.11180-3-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114100908.11180-3-tomislav.denis@avl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 11:09:07 +0100, <tomislav.denis@avl.com> wrote:
> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> All Sensors Corporation is a manufacturer of MEMS piezoresitive
> ultra low pressure sensors and pressure transducers.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
